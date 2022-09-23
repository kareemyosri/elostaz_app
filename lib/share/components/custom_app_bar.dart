import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';
import 'back_button_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const CustomAppBar(this.title, this.actions, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: BackButtonText()),
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(17),
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
        ),
      ],
    );
  }
}
