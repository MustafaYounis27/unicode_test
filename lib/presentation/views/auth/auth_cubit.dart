import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode_test/core/constants/app_session.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/data_access/cache/cache_helper.dart';
import 'package:unicode_test/core/network/repository.dart';
import 'package:unicode_test/data/models/user_model.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._repo) : super(AuthInitial());

  final FirebaseRepository _repo;

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool get loginButtonEnabled {
    if (emailController.text.isBlank) return false;
    if (passwordController.text.length < 6) return false;

    return true;
  }

  bool get registerButtonEnabled {
    if (nameController.text.isBlank) return false;
    if (emailController.text.isBlank) return false;
    if (passwordController.text.length < 6) return false;

    return true;
  }

  void login() async {
    emit(Loading());

    var response = await _repo.login(email: emailController.text, password: passwordController.text);

    await response.fold(
      (message) {
        emit(Error(message));
      },
      (user) async {
        if (user == null) {
          emit(Error('something went wrong'));
          return;
        }

        log(user.uid);

        AppSession.UID = user.uid;
        await injector.get<CacheHelper>().put('UID', user.uid);
        emit(UserLoginSuccessfuly());
      },
    );
  }

  Future<void> register() async {
    emit(Loading());
    var response = await _repo.register(email: emailController.text, password: passwordController.text);
    await response.fold(
      (message) {
        emit(Error(message));
      },
      (user) async {
        if (user == null) {
          emit(Error('something went wrong'));
          return;
        }

        AppSession.UID = user.uid;

        await injector.get<CacheHelper>().put('UID', user.uid);

        emit(UserRegisterSuccessfuly(user.uid));
      },
    );
  }

  Future<void> completeUserData(String UID) async {
    emit(Loading());
    var response = await _repo.completeUserData(
      user: UserModel(name: nameController.text, email: emailController.text, UID: UID),
    );

    await response.fold(
      (message) {
        emit(Error(message));
      },
      (_) async {
        emit(DataCompletedSuccessfuly());
      },
    );
  }
}
