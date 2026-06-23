import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeFormFieldWidget extends StatelessWidget {
  final List passList;
  final Function(dynamic) passedOnSuggestionSelected;
  final String noItemsFoundBuilderString, hintTextString;
  final String validatorString;
  final String? errortext;
  final bool? rOnly;
  final TextEditingController passedController;
  final String? Function(String?)? validate;
  const TypeFormFieldWidget(
      {super.key,
      this.rOnly = true,
      this.validate,
      required this.passList,
      required this.passedOnSuggestionSelected,
      required this.noItemsFoundBuilderString,
      required this.hintTextString,
      required this.validatorString,
      required this.passedController,
      this.errortext});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: (pattern) async {
        return passList
            .where(
              (item) => item.toUpperCase().contains(pattern.toUpperCase()),
            )
            .toList();
      },
      itemBuilder: (_, item) => ListTile(
          title: Text(
        item.toString(),
        style: GoogleFonts.poppins(
          fontSize: 12,
        ),
      )),
      onSelected: passedOnSuggestionSelected,
      builder: (context, controller, focusNode) {
        controller.text = passedController.text;
        return TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: rOnly!,
          style: GoogleFonts.poppins(
            fontSize: 12,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            filled: true,
            fillColor: Colors.white,
            hintText: hintTextString,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            labelStyle: const TextStyle(color: Colors.black87),
            errorText: errortext,
          ),
        );
      },
    );
  }
}

class KYCTypeFormFieldWidget extends StatelessWidget {
  final List passList;
  final Function(dynamic) passedOnSuggestionSelected;
  final String noItemsFoundBuilderString, hintTextString;
  final String validatorString;
  final TextEditingController passedController;
  const KYCTypeFormFieldWidget(
      {super.key,
      required this.passList,
      required this.passedOnSuggestionSelected,
      required this.noItemsFoundBuilderString,
      required this.hintTextString,
      required this.validatorString,
      required this.passedController});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: (pattern) async {
        return passList
            .where(
              (item) => item.toUpperCase().contains(pattern.toUpperCase()),
            )
            .toList();
      },
      itemBuilder: (_, item) => ListTile(title: Text(item.toString())),
      onSelected: passedOnSuggestionSelected,
      builder: (context, controller, focusNode) {
        controller.text = passedController.text;
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintTextString,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            labelStyle: const TextStyle(color: Colors.black87),
          ),
        );
      },
    );
  }
}
