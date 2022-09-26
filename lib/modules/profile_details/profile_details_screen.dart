import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/userModel.dart';
import '../../share/components/custom_app_bar.dart';
import '../../share/components/user_profile_image.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';
import '../Profile/cubit/user_cubit.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  //static const routeName = 'myProfile';
  //hhfghfghfghf
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserDataState>(
            builder: (BuildContext context, state) {
          var ProfileImage = UserCubit.get(context).ProfileImage;
          if (state is UserDataLoaded) {
            return Column(
              children: [
                CustomAppBar('My Profile', []),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                // ImageContainer(),
                UserProfileImage(imageUrl: UserCubit.get(context).user.image!),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                if (ProfileImage != null)
                  Row(
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                UserCubit.get(context).UploadProfileImage(
                                    email: UserCubit.get(context).user.email!,
                                    uid: UserCubit.get(context).user.uid!,
                                    phone: UserCubit.get(context).user.phone!,
                                    name: UserCubit.get(context).user.name!);
                              },
                              child: Text('Update Profile')),
                          if (state is UserUpdateLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                          if (state is UserUpdateLoadingState)
                            LinearProgressIndicator(),
                        ],
                      ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16.0),
                  ),
                  child: Column(
                    children: [
                      Divider(
                        height: getProportionateScreenHeight(64.0),
                      ),
                      InputFormCard(
                        title: 'Full name',
                        value: UserCubit.get(context).user.name!,
                      ),
                      InputFormCard(
                        title: 'Email',
                        value: UserCubit.get(context).user.email!,
                      ),
                      InputFormCard(
                        title: 'Phone number',
                        value: UserCubit.get(context).user.phone!,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          UserCubit.get(context).updateUser(
                              email: UserCubit.get(context).user.email!,
                              uid: UserCubit.get(context).user.uid!,
                              name: UserCubit.get(context).user.name!,
                              phone: UserCubit.get(context).user.phone!);
                        },
                        child: Text(
                          'Update',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

class InputFormCard extends StatelessWidget {
  const InputFormCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
            initialValue: value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(17),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
