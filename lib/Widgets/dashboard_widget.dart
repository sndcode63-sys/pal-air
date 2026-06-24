import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/appcolors.dart';

class DashBoardWidget extends StatelessWidget {
  final String title, iconString;
  final VoidCallback onPressed;

  const DashBoardWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconString,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      elevation: 4,
      shadowColor: primaryColor.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: primaryColor.withOpacity(0.12), width: 1),
      ),
      color: whiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: SvgPicture.asset(
                iconString,
                height: 28,
                width: 28,
                colorFilter: const ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
