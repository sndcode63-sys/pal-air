import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Screens/SplashScreen/splash_screen.dart';
import 'Utils/appcolors.dart';
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

/// Custom smooth scroll behaviour app-wide:
/// - No harsh Android "glow" overscroll, replaced with a soft bounce
///   (feels the same buttery way on Android and iOS).
class _SmoothScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}

/// Custom page transition builder so EVERY route (including any future
/// Navigator.push that doesn't go through RouteNames) gets the same
/// smooth fade + slide instead of the default platform animation.
class _SmoothPageTransitionsBuilder extends PageTransitionsBuilder {
  const _SmoothPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: const Cubic(0.22, 0.61, 0.16, 1.0),
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.04),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
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
            child: ScrollConfiguration(
              behavior: _SmoothScrollBehavior(),
              child: child!,
            ),
          );
        },
        title: 'PAL-Air',
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          useMaterial3: false,
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
          // App-wide default font = Poppins (matches the 150+ explicit
          // GoogleFonts.poppins() calls already used across screens), so
          // any text/widget that DOESN'T set an explicit style still gets
          // the same clean, modern font instead of falling back to the
          // platform default (Roboto/SF).
          textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
          // Smooth, consistent transitions on every platform (no more
          // jarring zoom-in on Android vs slide on iOS).
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: _SmoothPageTransitionsBuilder(),
              TargetPlatform.iOS: _SmoothPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteNames.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
