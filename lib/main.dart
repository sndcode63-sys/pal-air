// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/SplashScreen/splash_screen.dart';
import 'Utils/register_provider.dart';
import 'Utils/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: registerProviders,
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1)),
              child: child!);
        },





        title: 'Airo-Tech',
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          cardTheme: const CardThemeData(color: whiteColor),
          appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
          scaffoldBackgroundColor: whiteColor,

          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteNames.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
