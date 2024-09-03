import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/constants/app_session.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/core/network/repository.dart';
import 'package:unicode_test/core/router.dart';
import 'package:unicode_test/core/router.dart' as routes;
import 'package:unicode_test/core/theme/theme.dart';
import 'package:unicode_test/data/repositories/note_repository.dart';
import 'package:unicode_test/data_access/database/hive.dart';
import 'package:unicode_test/firebase_options.dart';
import 'package:workmanager/workmanager.dart';

ValueNotifier<DateTime?> reRenderWholeAppNotifier = ValueNotifier<DateTime?>(null);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabase().setup();
  await setUpInjector();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();

  BotToastInit();

  await Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );

  await Workmanager().registerPeriodicTask('6HourTask', 'checkAndUploadNotes', frequency: const Duration(hours: 6));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'EN'), Locale('ar', 'AR')],
      path: 'assets/lang',
      child: const MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    await setUpInjector();
    // Load unsynced notes from hive
    final unsyncedNotes = injector.get<NoteRepository>().getUnsyncedNotes();

    if (unsyncedNotes.isNotEmpty) {
      // Upload unsynced notes to Firebase

      for (var note in unsyncedNotes) {
        var result = await injector.get<FirebaseRepository>().uploadNote(UID: AppSession.UID, note: note);

        result.fold(
          (l) {},
          (_) {
            note.setNoteSynced();
            injector.get<NoteRepository>().handleSavedNote(note: note);
          },
        );
      }
    }

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return ValueListenableBuilder<DateTime?>(
      valueListenable: reRenderWholeAppNotifier,
      builder: (context, value, child) {
        return ScreenUtilInit(
          minTextAdapt: true,
          fontSizeResolver: (fontSize, instance) => fontSizeResolver(context, fontSize),
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          child: MaterialApp(
            title: 'UNICODE Test',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            initialRoute: '/',
            navigatorKey: Routes.navigatorKey,
            onGenerateRoute: routes.controller,
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return child;
            },
          ),
        );
      },
    );
  }

  double fontSizeResolver(BuildContext context, num fontSize) {
    const designTimeSize = Size(360, 690);
    final screen = MediaQuery.of(context).size;
    double scaleWidth = screen.width / designTimeSize.width;
    double scaleHeight = screen.height / designTimeSize.height;
    return fontSize * min(scaleWidth, scaleHeight);
  }
}

bool get determineDevicePreviewStatus {
  if (kReleaseMode) return false; //Don't enable device preview in release mode

  return false; //You are free to change this
}
