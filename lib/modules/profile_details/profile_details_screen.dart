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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserDataState>(
          builder: (BuildContext context, state) {
            if (state is UserDataLoaded) {
              return Column(
                children: [
                  const CustomAppBar('My Profile', []),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                  // ImageContainer(),
                  UserProfileImage(imageUrl: state.user.image!),
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
                          value: state.user.name!,
                        ),
                        // InputFormCard(
                        //   title: 'Birthdate',
                        //   value: '29 February 1200',
                        // ),
                        // InputFormCard(
                        //   title: 'Gender',
                        //   value: 'Male',
                        // ),
                        InputFormCard(
                          title: 'Email',
<<<<<<< HEAD
                          value: user.email,
=======
                          value: state.user.email!,
>>>>>>> ba061899954528c9da1976846597e3b499d65ce7
                        ),
                        InputFormCard(
                          title: 'Phone number',
                          value: state.user.phone!,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16.0),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed(LoginScreen.routeName);
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
            } else
              return const CircularProgressIndicator();
          },
        ),
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
