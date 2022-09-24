import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class UserProfileImage extends StatelessWidget {
  final String imageUrl;
  const UserProfileImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(112),
      width: getProportionateScreenWidth(112),
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: kGreyShade5,
                image: DecorationImage(image: NetworkImage(imageUrl))),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8),
              ),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: kPrimaryGreen,
              ),
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).cardColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
