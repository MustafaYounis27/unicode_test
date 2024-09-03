import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode_test/core/constants/app_session.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/core/network/repository.dart';
import 'package:unicode_test/data/models/note_model.dart';
import 'package:unicode_test/data/repositories/note_repository.dart';
import 'package:unicode_test/utils/view_list.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._repo) : super(HomeInitial());

  final FirebaseRepository _repo;

  ViewList<NoteModel> notes = ViewList([]);

  List<String> get allTopics => topics.toList();

  Set<String> topics = {};

  void initData() async {
    await getUserData();
    await fetchSyncedNotes();
    getUserNotes();
  }

  void navigateToAddNote() {
    emit(RouteToManageNote());
  }

  void navigateToEditNote(NoteModel note) {
    emit(RouteToManageNote(note: note));
  }

  Future<void> getUserData() async {
    emit(Loading());

    var result = await _repo.getUserData(UID: AppSession.UID);

    result.fold(
      (message) {
        emit(NeedToLogin());
      },
      (user) {
        if (user == null) {
          emit(NeedToLogin());
          return;
        }

        AppSession.loggedUser = user;

        emit(GetUserSuccessfully());
      },
    );
  }

  Future<void> fetchSyncedNotes() async {
    var n = await _repo.getUserNotes(UID: AppSession.UID);

    await n.fold(
      (l) {
        emit(Error(l));
      },
      (r) async {
        await injector.get<NoteRepository>().appendList(listItems: r, checkDuplicate: true);
      },
    );
  }

  void getUserNotes() {
    emit(Loading());

    notes = ViewList(injector.get<NoteRepository>().getList())..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    topics = injector.get<NoteRepository>().getAllTopics().toSet();

    emit(GetNotesSuccessfully());
  }

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  Set<String> filteredTopics = {};

  void enableSearchMode() {
    isSearching = true;
    searchController.clear();

    notes.reset();

    emit(Redraw());
  }

  void disableSearchMode() {
    isSearching = false;
    searchController.clear();

    notes.reset();
    filteredTopics.clear();
    emit(Redraw());
  }

  void addFilteredTopic(String topic) {
    filteredTopics.add(topic);

    search();
  }

  void removeFilteredTopic(String topic) {
    filteredTopics.remove(topic);

    search();
  }

  void clearSearch() {
    searchController.clear();

    search();
  }

  void search() {
    notes.filter((raw) => raw
        .where(
          (e) =>
              (e.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
                  e.body.toLowerCase().contains(searchController.text.toLowerCase())) &&
              (filteredTopics.isNotEmpty ? e.topics.where((t) => filteredTopics.contains(t)).isNotEmpty : true),
        )
        .toList());

    emit(Redraw());
  }

  Future<void> syncAllNotes() async {
    // Load unsynced notes from hive
    final unsyncedNotes = injector.get<NoteRepository>().getUnsyncedNotes();

    if (unsyncedNotes.isEmpty) {
      emit(NotAllyncedSuccessfully());
      return;
    }
    // Upload unsynced notes to Firebase

    emit(Loading());
    bool allSynced = true;

    for (var note in unsyncedNotes) {
      var result = await injector.get<FirebaseRepository>().uploadNote(UID: AppSession.UID, note: note);

      result.fold(
        (l) {
          allSynced = false;
        },
        (_) {
          note.setNoteSynced();
          injector.get<NoteRepository>().handleSavedNote(note: note);
        },
      );
    }
    if (allSynced) {
      emit(NotesSyncedSuccessfully());
    } else {
      emit(NotAllyncedSuccessfully());
    }
  }
}
