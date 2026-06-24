import 'package:flutter/material.dart';

import '../Utils/images.dart';

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
