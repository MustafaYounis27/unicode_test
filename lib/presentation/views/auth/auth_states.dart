part of 'auth_cubit.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class Redraw extends AuthStates {}

class Loading extends AuthStates {}

class Error extends AuthStates {
  final String message;

  Error(this.message);
}

class OTPSentSuccessfully extends AuthStates {
  final String message;

  OTPSentSuccessfully(this.message);
}

class UserLoginSuccessfuly extends AuthStates {}

class UserRegisterSuccessfuly extends AuthStates {
  final String UID;

  UserRegisterSuccessfuly(this.UID);
}

class DataCompletedSuccessfuly extends AuthStates {}
