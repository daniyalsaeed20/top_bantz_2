// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpCredentialsState extends SignUpState {
  SignUpCredentialsState({required this.userModel, required this.password});

  final UserModel userModel;
  final String password;

  @override
  List<Object> get props => [userModel, password];
}

class SignUpCreateAccountState extends SignUpState {}

class SignUpCreateAccountProcessState extends SignUpState {}
