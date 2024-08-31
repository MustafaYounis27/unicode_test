import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicode_test/core/network/error/exceptions.dart';
import 'package:unicode_test/data/models/note_model.dart';
import 'package:unicode_test/data/models/user_model.dart';

abstract class FirebaseRepository {
  Future<Either<String, User?>> login({
    required String email,
    required String password,
  });

  Future<Either<String, User?>> register({
    required String email,
    required String password,
  });

  Future<Either<String, void>> completeUserData({
    required UserModel user,
  });

  Future<Either<String, UserModel?>> getUserData({
    required String UID,
  });

  Future<Either<String, List<NoteModel>>> getUserNotes({
    required String UID,
  });

  Future<Either<String, void>> uploadNote({
    required String UID,
    required NoteModel note,
  });
}

//*****************************************************************************
class RepoImplementation extends FirebaseRepository {
  @override
  Future<Either<String, User?>> login({required String email, required String password}) async {
    return _basicErrorHandling<User?>(
      onSuccess: () async {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        return credential.user;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, User?>> register({required String email, required String password}) {
    return _basicErrorHandling<User?>(
      onSuccess: () async {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        return credential.user;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> completeUserData({required UserModel user}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        await FirebaseFirestore.instance.collection('users').doc(user.UID).set(user.toMap);

        return;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, UserModel?>> getUserData({required String UID}) {
    return _basicErrorHandling<UserModel?>(
      onSuccess: () async {
        var user = await FirebaseFirestore.instance.collection('users').doc(UID).get();

        if (!user.exists || user.data() == null) return null;

        return UserModel.fromMap(user.data()!);
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, List<NoteModel>>> getUserNotes({required String UID}) {
    return _basicErrorHandling<List<NoteModel>>(
      onSuccess: () async {
        var notes = await FirebaseFirestore.instance.collection('users').doc(UID).collection('notes').get();

        if (notes.docs.isEmpty) return [];

        List<NoteModel> notesList = [];

        for (var doc in notes.docs) {
          if (!doc.exists || doc.data().entries.isEmpty) continue;

          notesList.add(NoteModel.fromMap(doc.data()));
        }

        return notesList;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> uploadNote({required String UID, required NoteModel note}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        var collection = FirebaseFirestore.instance.collection('users').doc(UID).collection('notes');
        bool isLive = note.isLive;

        note.setNoteSynced();

        if (isLive) {
          await collection.doc(note.noteId).update(note.toMap);
        } else {
          await collection.doc(note.noteId).set(note.toMap);
        }

        return;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }
}

extension on FirebaseRepository {
  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(ServerException exception)? onServerError,
    Future<String> Function(CacheException exception)? onCacheError,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());

      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }

      return const Left('Server Error');
    } on CacheException catch (e) {
      debugPrint(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return const Left('Cache Error');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      }
      return const Left('something went wrong');
    } catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}
