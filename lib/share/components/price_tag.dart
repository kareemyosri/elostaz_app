import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class PriceTag extends StatelessWidget {
  final int price;
  const PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(8.0),
        horizontal: getProportionateScreenWidth(16.0),
      ),
      decoration: ShapeDecoration(
        color: kAccentGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8.0),
          ),
        ),
      ),
      child: Text(
        '${price}',
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: kPrimaryGreen,
            ),
      ),
    );
  }
}
