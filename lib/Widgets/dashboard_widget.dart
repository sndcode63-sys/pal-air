import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardWidget extends StatelessWidget {
  final String title, iconString;
  final VoidCallback onPressed;

  const DashBoardWidget(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.iconString});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: primaryColor)),
      color: primaryColor.withOpacity(0.8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: whiteColor, shape: BoxShape.circle),
              child: SvgPicture.asset(iconString,
                  height: 30,
                  width: 30,
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcIn)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: whiteColor, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
