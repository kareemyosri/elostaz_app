import 'package:flutter/material.dart';

import '../../share/components/back_button_ls.dart';
import '../../share/components/custom_text_field.dart';
import '../../share/components/option_button.dart';
import '../../share/components/or_row.dart';
import '../../share/components/social_media.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        'Log In Continue!',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SocialMediaLogin(
                    method: 'Login',
                  ),
                  const Spacer(),
                  const OrRow(),
                  const Spacer(),
                  const TextFields(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: kPrimaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed(TabScreen.routeName);
                    },
                    child: const Text('Login'),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  OptionButton(
                    desc: 'Don\'t have an account? ',
                    method: 'Sign Up',
                    onPressHandler: () {
                      // Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hint: 'Email Address',
        ),
        SizedBox(
          height: getProportionateScreenHeight(16),
        ),
        CustomTextField(
          hint: 'Password',
          icon: Image.asset('assets/images/hide_icon.png'),
        ),
      ],
    );
  }
}
