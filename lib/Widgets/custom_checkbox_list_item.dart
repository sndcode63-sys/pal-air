import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/MyComplains/ComplainDetail/helper_models.dart';

class CustomCheckBoxListItem extends StatelessWidget {
  final ReciprocatingModel item;
  final void Function(bool?) onCheckboxChanged;

  const CustomCheckBoxListItem(
      {super.key, required this.item, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCheckboxChanged(!item.isSelected);
      },
      child: Row(
        children: [
          Checkbox(
            value: item.isSelected,
            onChanged: onCheckboxChanged,
          ),
          Expanded(
            child: Text(
              item.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
