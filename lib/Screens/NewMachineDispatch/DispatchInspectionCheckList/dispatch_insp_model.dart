import 'package:flutter/material.dart';

class DispatchInspectionModel {
  final TextEditingController brandName;
  final TextEditingController components;
  final TextEditingController description;
  final TextEditingController nos;
  bool? isSelected;

  set changeSelection(bool val) {
    isSelected = val;
  }

  DispatchInspectionModel(
      {required this.brandName,
      required this.components,
      required this.description,
      required this.nos,
      this.isSelected});

  factory DispatchInspectionModel.fromJson(String compName) {
    return DispatchInspectionModel(
      brandName: TextEditingController(text: ""),
      components: TextEditingController(text: compName),
      description: TextEditingController(text: ""),
      nos: TextEditingController(text: ""),
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "brand_name": brandName.text,
        "components": components.text,
        "description": description.text,
        "nos": nos.text,
        "tick_mark": "1",
      };
}
