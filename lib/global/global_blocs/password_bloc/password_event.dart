// ignore_for_file: must_be_immutable

part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  PasswordEvent({required this.obscureText});
  bool obscureText;
  @override
  List<Object> get props => [obscureText];
}

class HidePasswordEvent extends PasswordEvent {
  HidePasswordEvent({required super.obscureText});

  @override
  List<Object> get props => [obscureText];
}

class ShowPasswordEvent extends PasswordEvent {
  ShowPasswordEvent({required super.obscureText});
  @override
  List<Object> get props => [obscureText];
}
