// ignore_for_file: must_be_immutable

part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  PasswordState({required this.obscureText});
  bool obscureText;
  @override
  List<Object> get props => [obscureText];
}

class PasswordInitial extends PasswordState {
  PasswordInitial({required super.obscureText});
}

class HidePasswordState extends PasswordState {
  HidePasswordState({required super.obscureText});

  @override
  List<Object> get props => [obscureText];
}

class ShowPasswordState extends PasswordState {
  ShowPasswordState({required super.obscureText});

  @override
  List<Object> get props => [obscureText];
}
