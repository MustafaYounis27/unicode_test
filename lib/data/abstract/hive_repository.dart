import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/data_access/database/hive.dart';

abstract class HiveRepository<T> {
  String boxName;
  late HiveDatabase _database;

  HiveRepository(this.boxName) {
    _database = injector.get<HiveDatabase>();
  }

  Iterable<T> getValues() {
    return _database.getValues<T>(name: boxName);
  }

  List<T> getList() {
    return (getValues()).toList();
  }

  Map<dynamic, T> getKeyValues() {
    return _database.getKeyValues<T>(name: boxName);
  }

  T? getSingle({required String query}) {
    return _database.getSingle<T>(name: boxName, query: query);
  }

  Iterable<T> getWhere({required bool Function(T) query}) {
    return _database.getWhere<T>(name: boxName, query: query);
  }

  T? getByIndex({required int index}) {
    return _database.getByIndex<T>(name: boxName, index: index);
  }

  Future insertList({required List<T> listItems}) async {
    return _database.saveList<T>(name: boxName, list: listItems);
  }

  Future appendList({required List<T> listItems, bool checkDuplicate = false}) async {
    return _database.appendList<T>(name: boxName, list: listItems, checkDuplicate: checkDuplicate);
  }

  Future insertSingle({required T item}) async {
    return _database.saveSingle<T>(name: boxName, item: item);
  }

  Future appendSingle({required T item}) async {
    return _database.appendSingle<T>(name: boxName, item: item);
  }

  Future deleteByIndex({required int index}) async {
    return _database.deleteByIndex<T>(name: boxName, index: index);
  }

  Future deleteByKey({required dynamic key}) async {
    return _database.deleteByKey<T>(name: boxName, key: key);
  }

  bool isEmpty() {
    return _database.isEmpty<T>(name: boxName);
  }

  Future deleteAll() async {
    return _database.deleteAll<T>(name: boxName);
  }

  Future update({required int index, required T item}) async {
    await _database.update<T>(name: boxName, index: index, value: item);
  }
}
