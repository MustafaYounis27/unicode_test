part of 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class Redraw extends HomeStates {}

class Loading extends HomeStates {}

class Error extends HomeStates {
  final String error;

  Error(this.error);
}

class RouteToManageNote extends HomeStates {
  final NoteModel? note;

  RouteToManageNote({this.note});
}

class NeedToLogin extends HomeStates {}

class GetUserSuccessfully extends HomeStates {}

class GetNotesSuccessfully extends HomeStates {}

class NotesSyncedSuccessfully extends HomeStates {}

class NotAllyncedSuccessfully extends HomeStates {}
