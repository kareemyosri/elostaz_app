import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class DiscoutText extends StatelessWidget {
  final int percent;
  const DiscoutText({required this.percent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(4),
      ),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: kAlertColor,
      ),
      child: Text(
        'Disc $percent%',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
