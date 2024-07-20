import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fitness_ui/ads_constant.dart';
import 'package:fitness_ui/apptheme/app_theme.dart';
import 'package:fitness_ui/apptheme/themeNotifier.dart';
import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/firebase_options.dart';
import 'package:fitness_ui/notification.dart';
import 'package:fitness_ui/ui/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'generated/l10n.dart';
import 'light_dark_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// automatically get breadcrumb logs to understand user actions leading up to a crash, non-fatal, or ANR event
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// This data can help you understand basic interactions, such as how many times your app was opened, and how many users were active in a chosen time period.
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  await getUserId();
  Get.put(CreateController());

  await initAppDetails();
  await LocalNotificationService.init();
  await LocalNotificationService.cancelAll();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await SharedPreferences.getInstance().then((prefs) {
    themeMode = prefs.getInt('themeMode') ?? 0;
    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) {
          ThemeModeNotifier(ThemeMode.values[themeMode]).setThemeMode(ThemeMode.values[themeMode]);
          return ThemeModeNotifier(ThemeMode.values[themeMode]);
        },
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (themeMode == 0) {
      AppTheme.setSystemUIOverlayStyle(ThemeMode.values[themeMode]);
    }
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppTheme.setSystemUIOverlayStyle(ThemeMode.values[themeMode]);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);
    return ScreenUtilInit(
      designSize: isTab(context) ? const Size(585, 812) : const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          title: "Pro Fitness",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.getThemeMode,
          locale: Locale(languageCode!),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
