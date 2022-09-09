import 'package:form_field_validator/form_field_validator.dart';

class CustomValidators {
  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field cannot be empty'),
  ]);

  final creditCardValidator = MultiValidator([
    RequiredValidator(errorText: 'First name is required'),
    MinLengthValidator(19, errorText: 'Enter a valid 16 digits card number'),
  ]);
  final emptyValidator = MultiValidator([]);
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email cannot be empty'),
    PatternValidator(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
        errorText: 'email format incorrect')
  ]);
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password cannot be empty'),
    PatternValidator(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
        errorText: 'Password format incorrect')
  ]);

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First name is required'),
    MinLengthValidator(1,
        errorText: 'first name must be at least 1 characters long'),
    MaxLengthValidator(30,
        errorText: 'first name must not be more than 30 characters'),
    PatternValidator(r"^([A-Z][A-Za-z.'\-]+)$",
        errorText: 'Capitalize first letter or remove spaces')
  ]);
  final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Last name is required'),
    MinLengthValidator(1,
        errorText: 'last name must be at least 1 characters long'),
    MaxLengthValidator(30,
        errorText: 'last name must not be more than 30 characters'),
    PatternValidator(r"^([A-Z][A-Za-z.'\-]+)$",
        errorText: 'Capitalize first letter or remove spaces')
  ]);

  final fullNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
    MinLengthValidator(1, errorText: 'Name must be at least 1 characters long'),
    PatternValidator(r'^[a-z A-Z,.\-]+$', errorText: 'Incorrect name')
  ]);
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
