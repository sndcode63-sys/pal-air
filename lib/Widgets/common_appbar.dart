import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar commonAppBar(
    {required BuildContext context,
    required String heading,
    String? subtitle,
    double? elv = 0,
    PreferredSizeWidget? bottom,
    List<Widget>? widgetList,
    VoidCallback? onPressed}) {
  return AppBar(
    backgroundColor: whiteColor,
    elevation: elv,
    centerTitle: true,
    title: Text(
      heading,
      style: GoogleFonts.poppins(
          color: primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    actions: widgetList,
    bottom: bottom,
    leading: InkWell(
        onTap: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(8)),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 15,
              color: whiteColor,
            ))),
  );
}
