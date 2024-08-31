part of 'manage_note_cubit.dart';

abstract class ManageNoteStates {}

class ManageNoteInit extends ManageNoteStates {}

class Redraw extends ManageNoteStates {}

class Loading extends ManageNoteStates {}

class Error extends ManageNoteStates {
  final String error;

  Error(this.error);
}

class NoteSavedSuccessfully extends ManageNoteStates {
  final bool editMode;

  NoteSavedSuccessfully(this.editMode);
}
