import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            color: primaryColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Loading",
            style: GoogleFonts.poppins(
                color: primaryColor, fontSize: 13, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class ExpandedCommonLoader extends StatelessWidget {
  const ExpandedCommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            color: primaryColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Loading",
            style: GoogleFonts.poppins(
                color: primaryColor, fontSize: 13, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
