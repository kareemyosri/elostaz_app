import 'dart:io';

import 'package:elostaz_app/modules/Profile/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<UserCubit, UserDataState>(
      builder: (BuildContext context, state) {
        if (state.userDataStatus == UserDataStatus.loaded) {
          return Container(
            height: getProportionateScreenWidth(112),
            width: getProportionateScreenWidth(112),
            child: Stack(
              children: [
                Container(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: kGreyShade5,
                    image: DecorationImage(
                      image: NetworkImage(state.user.image!),
                      // (context.watch<UserCubit>().state.updatedUser.image ==
                      //         null)
                      //     ? NetworkImage(state.user.image!)
                      //     : FileImage(File(state.updatedUser.image!))
                      //         as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      UserCubit.get(context).getProfileImage();
                    },
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
                  ),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
