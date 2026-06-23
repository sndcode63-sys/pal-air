import 'package:airo_tech/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedDropDownWidget extends StatefulWidget {
  final List? dropMenuList;
  final String? labelText;
  final Function? selectedReturnValue;
  final String? hintText;

  const ExpandedDropDownWidget({
    Key? key,
    required this.dropMenuList,
    required this.labelText,
    this.hintText = "",
    required this.selectedReturnValue,
  }) : super(key: key);

  @override
  State<ExpandedDropDownWidget> createState() => _ExpandedDropDownWidgetState();
}

class _ExpandedDropDownWidgetState extends State<ExpandedDropDownWidget> {
  List? notify;
  String? selectedMenuItem;

  @override
  void initState() {
    notify = widget.dropMenuList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconSize: 25,
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          iconEnabledColor: blackColor,
          iconDisabledColor: blackColor,
          dropdownColor: whiteColor,
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: whiteColor,
          ),
          hint: Text(
            widget.hintText!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: blackColor,
            ),
          ),
          items: notify!.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  color: blackColor,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() => selectedMenuItem = newValue.toString());
            widget.selectedReturnValue!(selectedMenuItem);
          },
          value: selectedMenuItem,
        ),
      ),
    );
  }
}
