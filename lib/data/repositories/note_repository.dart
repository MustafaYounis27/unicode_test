import 'package:unicode_test/data/abstract/hive_repository.dart';
import 'package:unicode_test/data/models/note_model.dart';
import 'package:unicode_test/data_access/database/hive_constant.dart';

class NoteRepository extends HiveRepository<NoteModel> {
  NoteRepository(String boxName) : super(HiveBoxes.note);

  void handleSavedNote({required NoteModel note, bool isNew = false}) async {
    if (!isNew) {
      var list = getList();

      int index = list.indexWhere((e) => e.noteId == note.noteId);

      if (index != -1) {
        await update(index: index, item: note);
        return;
      }
    }

    await appendSingle(item: note);
  }

  List<String> getAllTopics() {
    if (isEmpty()) return [];

    var notes = getList();

    return notes.map((e) => e.topics).expand((e) => e).toList();
  }

  List<NoteModel> getUnsyncedNotes() {
    if (isEmpty()) return [];

    return getList().where((e) => !e.isLive || e.isUpdated).toList();
  }
}
