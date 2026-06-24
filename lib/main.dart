import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/SplashScreen/splash_screen.dart';
import 'Utils/register_provider.dart';
import 'Utils/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
            child: child!,
          );
        },
        title: 'PAL-Air',
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          cardTheme: const CardThemeData(color: whiteColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          scaffoldBackgroundColor: bgColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteNames.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
