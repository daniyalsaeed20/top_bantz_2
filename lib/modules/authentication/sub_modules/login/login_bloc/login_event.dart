// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AttemptLoginEvent extends LoginEvent {
  AttemptLoginEvent({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginFailedEvent extends LoginEvent {
  const LoginFailedEvent();

  @override
  List<Object> get props => [];
}
