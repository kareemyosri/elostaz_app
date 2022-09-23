import 'package:elostaz_app/modules/login/login_cubit.dart';
import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/share/components/custom_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
    final AuthRepo authRepo = AuthRepo();
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(authRepo),
      child: const LoginScreenBody(),
    );
  }
}

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

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
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.status == FormzStatus.submissionFailure) {
                        showtoast(
                          text: state.errorMessage ?? 'Authentication Failure',
                          state: ToastStates.ERROR,
                        );
                      } else if (state.status ==
                          FormzStatus.submissionSuccess) {
                        showtoast(
                          text: 'Logged In Sucessfully',
                          state: ToastStates.SUCCESS,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () => state.status.isValidated
                            ? context.read<LoginCubit>().logInWithCredentials()
                            : null,
                        child: state.status.isSubmissionInProgress
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
                      );
                    },
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
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return CustomTextField(
              errorText: state.email.invalid ? 'invalid email' : null,
              hint: 'Email Address',
              onChanged: (value) =>
                  context.read<LoginCubit>().emailChanged(value),
            );
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(16),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return CustomTextField(
              hint: 'Password',
              // errorText: state.password.invalid ? 'invalid p' : null,
              icon: Image.asset('assets/images/hide_icon.png'),
              onChanged: (value) =>
                  context.read<LoginCubit>().passwordChanged(value),
            );
          },
        ),
      ],
    );
  }
}
