import 'package:elostaz_app/share/components/custom_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../share/components/custom_app_bar.dart';
import '../../share/components/user_profile_image.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';
import '../Profile/cubit/user_cubit.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserDataState>(
            listener: (BuildContext context, state) {
          if (state.userUpdateStatus == UserUpdateStatus.success) {
            showtoast(
                text: 'Profile Updated Successfully',
                state: ToastStates.SUCCESS);
            Navigator.of(context).pop();
            UserCubit.get(context).initUpdateStatus();
          } else if (state.userUpdateStatus == UserUpdateStatus.error) {
            showtoast(
                text: 'Error while updating Profile', state: ToastStates.ERROR);
          }
        }, builder: (BuildContext context, state) {
          if (state.userDataStatus == UserDataStatus.loaded) {
            return Column(
              children: [
                const CustomAppBar('My Profile', []),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                // ImageContainer(),
                UserProfileImage(
                  imageUrl: state.user.image!,
                  showEditIcon: true,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
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
                        value: state.user.name!,
                        errorText: state.updatedName.invalid
                            ? 'Name must be +2 in length'
                            : null,
                        onChanged: (value) =>
                            UserCubit.get(context).updateName(value),
                      ),
                      InputFormCard(
                        title: 'Email',
                        value: state.user.email,
                        errorText: state.updatedEmail.invalid
                            ? 'Wrong email format'
                            : null,
                        onChanged: (value) =>
                            UserCubit.get(context).updateEmail(value),
                      ),
                      InputFormCard(
                        title: 'Phone number',
                        value: state.user.phone!,
                        errorText: state.updatedPhone.invalid
                            ? 'Wrong phone format (11 chars is required)'
                            : null,
                        onChanged: (value) =>
                            UserCubit.get(context).updatePhone(value),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16.0),
                      ),
                      if (state.updatedUser != state.user &&
                          state.updatedUserStatus == FormzStatus.valid)
                        ElevatedButton(
                          onPressed: () =>
                              UserCubit.get(context).updateUserData(),
                          child: (state.userUpdateStatus !=
                                  UserUpdateStatus.loading)
                              ? const Text('Update')
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
// This comment will be deleted
class InputFormCard extends StatelessWidget {
  const InputFormCard({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.errorText = '',
  }) : super(key: key);

  final String title;
  final String value;
  final String? errorText;
  final Function(String)? onChanged;
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
            onChanged: onChanged,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(17),
            ),
            decoration: InputDecoration(
              errorMaxLines: 2,
              errorText: errorText,
              errorStyle: const TextStyle(color: Colors.red),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
