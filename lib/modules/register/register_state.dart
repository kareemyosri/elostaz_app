part of 'register_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

// ignore: must_be_immutable
class RegisterState extends Equatable {
  const RegisterState({
    this.name = const Name.pure(),
    // this.address = const Name.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final Name name;
  final Email email;
  // final Name address;
  final Phone phone;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [name, email, phone, password, status];

  RegisterState copyWith({
    Name? name,
    // Name? address,
    Email? email,
    Password? password,
    Phone? phone,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      // address: address ?? this.address,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
