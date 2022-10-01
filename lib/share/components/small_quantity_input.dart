import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class SmallQuantityInput extends StatelessWidget {
  const SmallQuantityInput({
    Key? key,
    required this.value,
  }) : super(key: key);
  final int value;
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController =
        TextEditingController(text: value.toString());

    return SizedBox(
      width: getProportionateScreenWidth(32),
      child: TextField(
        enabled: false,
        controller: textController,
        decoration: InputDecoration(
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8),
            ),
            borderSide: const BorderSide(
              color: kGreyShade3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8),
            ),
            borderSide: const BorderSide(
              color: kGreyShade3,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(0),
            horizontal: getProportionateScreenWidth(4),
          ),
        ),
        style: TextStyle(
          fontSize: getProportionateScreenWidth(20),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
