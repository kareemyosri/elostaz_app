import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:elostaz_app/share/form_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepo) : super(const RegisterState());
  final AuthRepo _authRepo;
  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        // state.address,
        state.phone,
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.name,
        email,
        // state.address,
        state.phone,
        state.password,
      ]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.name,
        state.email,
        // state.address,
        phone,
        state.password,
      ]),
    ));
  }

  void addressChanged(String value) {
    final address = Name.dirty(value);
    emit(state.copyWith(
      // address: address,
      status: Formz.validate([
        state.name,
        state.email,
        address,
        state.phone,
        state.password,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.name,
        state.email,
        // state.address,
        state.phone,
        password,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String? uid = await _authRepo.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      if (uid != null) {
        final DatabaseRepo databaseRepo = DatabaseRepo(uid: uid);
        UserModel user = UserModel(
          uid: uid,
          email: state.email.value,
          name: state.name.value,
          phone: state.phone.value,
          image: '',
        );
        print(user);
        await databaseRepo.addUserData(user);
      }
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
}
