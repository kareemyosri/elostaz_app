import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/share/form_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo) : super(const SignUpState());

  final AuthRepo _authRepo;
  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.password,
        // state.confirmedPassword,
      ]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = Name.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        state.firstName,
        lastName,
        state.email,
        state.password,
        // state.confirmedPassword,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        email,
        state.password,

        //state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    // final confirmedPassword = ConfirmedPassword.dirty(
    //   password: password.value,
    //   value: state.confirmedPassword.value,
    // );
    emit(state.copyWith(
      password: password,
      //confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        password,
        // confirmedPassword,
      ]),
    ));
  }

  // void confirmedPasswordChanged(String value) {
  //   final confirmedPassword = ConfirmedPassword.dirty(
  //     password: state.password.value,
  //     value: value,
  //   );
  //   emit(state.copyWith(
  //     confirmedPassword: confirmedPassword,
  //     status: Formz.validate([
  //       state.email,
  //       state.password,
  //       confirmedPassword,
  //     ]),
  //   ));
  // }
  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      print(
          'Signing in with ${state.firstName.value} ${state.lastName.value}, ${state.email.value}');
      await _authRepo.signUp(
        fullname: '${state.firstName.value} ${state.lastName.value}',
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> updatePhotoURL() async {
    // await _authRepo.signUp(
    //   fullname: state.firstName.value,
    //   email: state.email.value,
    //   password: state.password.value,
    // );
    // emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
