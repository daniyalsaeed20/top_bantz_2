part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class AttemptLoginState extends LoginState {}
class LoginFailedState extends LoginState {}
class LoginEmailVerifiedState extends LoginState {}
class LoginEmailNotVerifiedState extends LoginState {}
