part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

// ignore: must_be_immutable
class SignUpState extends Equatable {
  const SignUpState({
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final Name firstName;
  final Name lastName;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [firstName, lastName, email, password, confirmedPassword, status];

  SignUpState copyWith({
    Name? firstName,
    Name? lastName,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
