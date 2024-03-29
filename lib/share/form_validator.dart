import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].

// Define input validation errors
enum NameValidationError { empty }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameValidationError> {
  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty([String value = '']) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameValidationError? validator(String value) {
    return value.length > 2 ? null : NameValidationError.empty;
  }
}

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Email extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const Email.pure() : super.pure('');

  /// {@macro email}
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PhoneValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([String value = '']) : super.dirty(value);

  // static final _passwordRegExp =
  //     RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PhoneValidationError? validator(String? value) {
    return value!.length > 3 // _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}

// Validation errors for the [Password] [FormzInput].
enum PhoneValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Phone extends FormzInput<String, PhoneValidationError> {
  /// {@macro password}
  const Phone.pure() : super.pure('');

  /// {@macro password}
  const Phone.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegExp = RegExp(r'^01[0125][0-9]{8}$');

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}
