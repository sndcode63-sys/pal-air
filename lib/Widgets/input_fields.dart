import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/appcolors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controllerValue;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Widget? pref, suf;
  final bool? rOnly;
  final TextInputType? inputType;
  final TextInputAction? actionNext;
  final bool? obsText;
  final int? mLength;

  final String? Function(String?)? validate;
  final String? hintText;
  const LoginTextField(
      {super.key,
      this.pref,
      this.suf,
      this.controllerValue,
      this.obsText = false,
      this.validate,
      this.onTap,
      this.rOnly = false,
      this.inputType,
      this.actionNext,
      this.mLength,
      this.hintText,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      enableInteractiveSelection: false,
      onChanged: onChange,
      style: GoogleFonts.poppins(fontSize: 13, color: blackColor),
      cursorColor: primaryColor,
      readOnly: rOnly!,
      textInputAction: actionNext,
      onTap: onTap,
      keyboardType: inputType,
      obscureText: obsText!,
      validator: validate!,
      controller: controllerValue!,
      maxLength: mLength,
      decoration: InputDecoration(
          prefixIcon: pref,
          suffixIcon: suf,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: whiteColor,
          counterText: '',
          errorStyle: GoogleFonts.poppins(color: Colors.red),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: blackColor,
            fontSize: 12,
            letterSpacing: 1,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
    );
  }
}

class StepperTextField extends StatelessWidget {
  final TextEditingController? controllerValue;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Widget? suf;
  final bool? rOnly;
  final TextInputType? inputType;
  final TextInputAction? actionNext;
  final bool? obsText;
  final int? maxLine, mLength;

  final String? Function(String?)? validate;
  final String? hintValue;
  const StepperTextField(
      {super.key,
      this.suf,
      this.controllerValue,
      this.obsText = false,
      this.validate,
      this.onTap,
      this.rOnly = false,
      this.inputType,
      this.actionNext,
      this.mLength,
      this.maxLine,
      this.hintValue,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
      cursorColor: Colors.black87,
      readOnly: rOnly!,
      onTap: onTap,
      keyboardType: inputType,
      validator: validate!,
      controller: controllerValue!,
      maxLength: mLength,
      decoration: InputDecoration(
          suffixIcon: suf,
          label: Text(hintValue!),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          hintText: hintValue,
          alignLabelWithHint: true,
          hintStyle: GoogleFonts.poppins(
            fontSize: 12,
            letterSpacing: 1,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
    );
  }
}

class DispatchInspTextField extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  final bool? rOnly;
  final TextEditingController? controllerValue;
  final TextAlign? textAlignment;
  const DispatchInspTextField(
      {super.key,
      this.rOnly = false,
      this.textAlignment,
      required this.hint,
      required this.onTap,
      required this.controllerValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
      controller: controllerValue,
      onTap: onTap,
      readOnly: rOnly!,
      textAlign: textAlignment ?? TextAlign.center,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 12,
            letterSpacing: 1,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
    );
  }
}
