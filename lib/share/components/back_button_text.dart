import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BackButtonText extends StatelessWidget {
  const BackButtonText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryGreen,
          ),
          Text(
            'Back',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: kPrimaryGreen,
                ),
          ),
        ],
      ),
    );
  }
}
