import 'package:elostaz_app/modules/login/login_screen.dart';
import 'package:elostaz_app/modules/register/register_cubit.dart';
import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/share/components/custom_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../share/components/custom_text_field.dart';
import '../../share/components/option_button.dart';

import '../../share/utils/screen_utils.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    final AuthRepo authRepo = AuthRepo();
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(authRepo),
      child: const SignupScreenBody(),
    );
  }
}

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

//
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BackButtonLS(),
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
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // SocialMediaLogin(
                    //   method: 'Sign Up',
                    // ),
                    // Spacer(),
                    // OrRow(),
                    // Spacer(),
                    CustomTextField(
                      hint: 'Your Name',
                      onChanged: (value) =>
                          context.read<RegisterCubit>().nameChanged(value),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            hint: '+20',
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomTextField(
                            hint: 'Phone Number',
                            onChanged: (value) => context
                                .read<RegisterCubit>()
                                .phoneChanged(value),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomTextField(
                      hint: 'Email Address',
                      onChanged: (value) =>
                          context.read<RegisterCubit>().emailChanged(value),
                    ),
                    const Spacer(),
                    CustomTextField(
                      hint: 'Password',
                      icon: const Icon(Icons.remove_red_eye),
                      onChanged: (value) =>
                          context.read<RegisterCubit>().passwordChanged(value),
                    ),
                    const Spacer(),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state.status == FormzStatus.submissionFailure) {
                          showtoast(
                            text:
                                state.errorMessage ?? 'Authentication Failure',
                            state: ToastStates.ERROR,
                          );
                        } else if (state.status ==
                            FormzStatus.submissionSuccess) {
                          Navigator.of(context).pop();

                          showtoast(
                            text: 'Registered Successfully',
                            state: ToastStates.SUCCESS,
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state.status.isValidated) {
                              context
                                  .read<RegisterCubit>()
                                  .signUpFormSubmitted();
                            }
                          },
                          child: state.status.isSubmissionInProgress
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Sign Up'),
                        );
                      },
                    ),
                    const Spacer(),
                    OptionButton(
                        desc: 'Have an account? ',
                        method: 'Login',
                        onPressHandler: () => Navigator.of(context)
                            .pop() // Navigator.of(context).push<void>(LoginScreen.page()),
                        ),
                    const Spacer(),
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
