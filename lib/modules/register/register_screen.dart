import 'package:flutter/material.dart';

import '../../share/components/back_button_ls.dart';
import '../../share/components/custom_text_field.dart';
import '../../share/components/option_button.dart';
import '../../share/components/or_row.dart';
import '../../share/components/social_media.dart';
import '../../share/utils/screen_utils.dart';


class SignupScreen extends StatelessWidget {
//
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonLS(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sign Up Continue!',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // SocialMediaLogin(
                    //   method: 'Sign Up',
                    // ),
                    // Spacer(),
                    // OrRow(),
                    // Spacer(),
                    CustomTextField(
                      hint: 'Your Name', onChanged: (String ) {  },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            hint: '+20',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ), onChanged: (String ) {  },
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomTextField(
                            hint: 'Phone Number', onChanged: (String ) {  },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomTextField(hint: 'Email Address', onChanged: (String ) {  },),
                    Spacer(),
                    CustomTextField(
                      hint: 'Password',
                      icon: Image.asset('assets/images/hide_icon.png'), onChanged: (String ) {  },
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushNamed(AddAddressScreen.routeName);
                      },
                      child: Text('Sign Up'),
                    ),
                    Spacer(),
                    OptionButton(
                      desc: 'Have an account? ',
                      method: 'Login',
                      onPressHandler: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
