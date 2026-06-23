import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget btnTitle;
  final VoidCallback? onTap;
  const AppButton({super.key, required this.btnTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(7)),
        child: btnTitle,
      ),
    );
  }
}
