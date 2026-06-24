import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar commonAppBar({
  required BuildContext context,
  required String heading,
  double? elv = 0,
  PreferredSizeWidget? bottom,
  List<Widget>? widgetList,
  VoidCallback? onPressed,
}) {
  return AppBar(
    backgroundColor: primaryColor,
    elevation: elv,
    centerTitle: true,
    title: Text(
      heading,
      style: GoogleFonts.poppins(
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    iconTheme: const IconThemeData(color: whiteColor),
    actions: widgetList,
    bottom: bottom,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
    leading: InkWell(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: whiteColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.arrow_back_ios_rounded, size: 15, color: whiteColor),
      ),
    ),
  );
}
