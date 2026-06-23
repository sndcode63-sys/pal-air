import 'package:airo_tech/Utils/images.dart';
import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Image.asset(Images.noDataImage)],
    );
  }
}
