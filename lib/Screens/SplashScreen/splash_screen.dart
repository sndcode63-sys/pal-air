import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/images.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'splash_screen_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashScreenProvider>(context, listen: false)
          .checkVersion(context);
    });
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo in white circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )],
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Image.asset(Images.appLogo),
                ),
                const SizedBox(height: 28),
                // Horizontal rule
                Container(height: 2, width: 180, color: whiteColor.withOpacity(0.7)),
                const SizedBox(height: 10),
                Text(
                  "PAL-AIR",
                  style: GoogleFonts.rajdhani(
                    color: whiteColor,
                    fontSize: 46,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                  ),
                ),
                Container(height: 2, width: 180, color: whiteColor.withOpacity(0.7)),
                const SizedBox(height: 14),
                Text(
                  "Leader in Ventilation Technology",
                  style: GoogleFonts.poppins(
                    color: whiteColor.withOpacity(0.80),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
