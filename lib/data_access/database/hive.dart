import 'package:unicode_test/data/models/note_model.dart';

import 'hive_constant.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDatabase {
  final String databasePath = 'database';

  Future setup() async {
    await Hive.initFlutter(databasePath);
    registerAdapters();
    await openBoxes();
  }

  void registerAdapters() {
    Hive.registerAdapter(NoteModelAdapter());
  }

  Future<void> openBoxes() async {
    await _openBox<NoteModel>(HiveBoxes.note);
  }

  Future<dynamic> _openBox<T>(String name) async {
    if (!Hive.isBoxOpen(name)) {
      try {
        return await Hive.openBox<T>(name);
      } catch (_) {}
    }
  }

  Future saveList<T>({required String name, required List<T> list}) async {
    Box<T> box = Hive.box<T>(name);
    await box.clear();
    await box.addAll(list);
  }

  Future saveSingle<T>({required String name, required T item}) async {
    Box<T> box = Hive.box<T>(name);
    await box.clear();
    await box.add(item);
  }

  Future appendSingle<T>({required String name, required T item}) async {
    Box<T> box = Hive.box<T>(name);

    await box.add(item);
  }

  T? getSingle<T>({required String name, required String query}) {
    Box<T> box = Hive.box<T>(name);

    return box.get(query);
  }

  Iterable<T> getWhere<T>({required String name, required bool Function(T) query}) {
    Box<T> box = Hive.box<T>(name);

    return box.values.where((query));
  }

  T? getByIndex<T>({required String name, required int index}) {
    Box<T> box = Hive.box<T>(name);

    return box.getAt(index);
  }

  Iterable<T> getValues<T>({required String name}) {
    Box<T> box = Hive.box<T>(name);
    return box.values;
  }

  Future update<T>({required String name, required int index, required T value}) async {
    Box<T> box = Hive.box<T>(name);
    return box.putAt(index, value);
  }

  Future deleteAll<T>({required String name}) async {
    Box<T> box = Hive.box<T>(name);
    await box.clear();
  }

  bool isEmpty<T>({required String name}) {
    Box<T> box = Hive.box<T>(name);
    return box.isEmpty;
  }

  Future deleteByIndex<T>({required String name, required int index}) async {
    Box box = Hive.box<T>(name);
    return box.deleteAt(index);
  }

  Future deleteByKey<T>({required String name, required key}) async {
    Box box = Hive.box<T>(name);
    return box.delete(key);
  }

  Map<dynamic, T> getKeyValues<T>({required String name}) {
    Box<T> box = Hive.box<T>(name);

    Map<dynamic, T> result = {};
    for (var element in box.keys) {
      result[element] = box.get(element) as T;
    }

    return result;
  }

  Future appendList<T>({required String name, required List<T> list, bool checkDuplicate = false}) async {
    Box<T> box = Hive.box<T>(name);
    if (checkDuplicate == true) {
      //Get box data as key/value
      var keysValues = getKeyValues<T>(name: name);
      for (var element in list) {
        if (element is NoteModel) {
          if (box.values.contains(element)) {
            await deleteByKey<T>(name: name, key: keysValues.entries.firstWhere((e) => e.value == element).key);
          }
        }

        //Add to box
        await box.add(element);
      }
    } else {
      await box.addAll(list);
    }

    return box;
  }
}
