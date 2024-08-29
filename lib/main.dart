import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/core/resource/theme.dart';
import 'package:todo/core/utils/storage_manager.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/presentation/screens/screen_home.dart';
import 'package:todo/screens/home/settings/blocs/settings_cubit.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('bn')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: BlocProvider(
        create: (context) => SettingsCubit(),
        child: const MyApp(),
      ))
  );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static FirebaseAnalyticsObserver firebaseObserver = FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    DioSingleton.instance.create("6b4e80e85796a8845ebc68e7d9c9e67486f0cfe8");
    StorageManager.instance.create();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme(createTextTheme(context, "Montserrat", "Montserrat")).light(),
      darkTheme: MaterialTheme(createTextTheme(context, "Montserrat", "Montserrat")).dark(),
      themeMode: context.watch<SettingsCubit>().state.theme,
      routerConfig: GoRouter(
        navigatorKey: navigatorKey,
        observers: <NavigatorObserver>[routeObserver, firebaseObserver],
        initialLocation: ScreenHome.routeName,
        routes: routes,
      ),
    );
  }
}


