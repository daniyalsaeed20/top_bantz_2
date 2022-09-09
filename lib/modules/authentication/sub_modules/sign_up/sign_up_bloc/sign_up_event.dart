// ignore_for_file: must_be_immutable

part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpCredentialsEvent extends SignUpEvent {
  SignUpCredentialsEvent({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.confirmPassword,
    required this.password,
  });

  String fullName;
  String email;
  String password;
  String confirmPassword;
  String contactNumber;

  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        confirmPassword,
        contactNumber,
      ];
}

class SignUpCreateAccountEvent extends SignUpEvent {
  SignUpCreateAccountEvent({required this.licenseNumber});
  String licenseNumber;
  @override
  List<Object> get props => [licenseNumber];
}
