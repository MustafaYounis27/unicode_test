import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/data/models/note_model.dart';
import 'package:unicode_test/data/repositories/note_repository.dart';
import 'package:uuid/uuid.dart';

part 'manage_note_states.dart';

class ManageNoteCubit extends Cubit<ManageNoteStates> {
  ManageNoteCubit() : super(ManageNoteInit());

  final NoteRepository _noteRepo = injector.get<NoteRepository>();

  NoteModel? note;
  bool isEditMode = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Set<String> topics = {'General'};

  void initData(NoteModel? note) {
    this.note = note;

    handleEditMode();
  }

  void handleEditMode() {
    if (note == null) return;
    isEditMode = true;

    titleController.text = note!.title;
    bodyController.text = note!.body;
    topics = note!.topics.toSet();

    emit(Redraw());
  }

  String get noteId {
    if (isEditMode) return note!.noteId;
    return const Uuid().v4();
  }

  DateTime get createdAt {
    if (isEditMode) return note!.createdAt;
    return DateTime.now();
  }

  bool get isLive {
    if (isEditMode) return note!.isLive;
    return false;
  }

  bool get isUpdated {
    if (isEditMode) return true;
    return false;
  }

  Future<void> handleSaveNote() async {
    NoteModel noteToSave = NoteModel(
      noteId: noteId,
      title: titleController.text,
      body: bodyController.text,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      topics: topics.toList(),
      isLive: isLive,
      isUpdated: isUpdated,
    );

    _noteRepo.handleSavedNote(note: noteToSave, isNew: !isEditMode);

    emit(NoteSavedSuccessfully(isEditMode));
  }

  void addNewTopic(String topic) {
    topics.add(topic);

    emit(Redraw());
  }

  void removeTopic(String topic) {
    topics.remove(topic);

    emit(Redraw());
  }
}
