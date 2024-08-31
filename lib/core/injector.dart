import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicode_test/data_access/cache/cache_helper.dart';
import 'package:unicode_test/core/network/repository.dart';
import 'package:unicode_test/data/repositories/note_repository.dart';
import 'package:unicode_test/data_access/database/hive.dart';
import 'package:unicode_test/data_access/database/hive_constant.dart';

final injector = GetIt.instance;

Future<void> setUpInjector() async {
  injector.registerLazySingleton<CacheHelper>(() => CacheImpl(injector()));
  injector.registerLazySingleton<RepoImplementation>(() => RepoImplementation());
  injector.registerLazySingleton<FirebaseRepository>(() => injector.get<RepoImplementation>());
  injector.registerLazySingleton<HiveDatabase>(() => HiveDatabase());
  injector.registerLazySingleton<NoteRepository>(() => NoteRepository(HiveBoxes.note));

  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => sharedPreferences);
}
