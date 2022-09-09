part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStartedState extends AuthState {
  const AuthStartedState();

  @override
  List<Object> get props => [];
}
class AuthSuccessState extends AuthState {
  const AuthSuccessState();

  @override
  List<Object> get props => [];
}
class AuthFailedState extends AuthState {
  const AuthFailedState();

  @override
  List<Object> get props => [];
}

class VerifyEmailState extends AuthState {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class EmailVerifiedState extends AuthState {
  const EmailVerifiedState();

  @override
  List<Object> get props => [];
}

class EmailNotVerifiedState extends AuthState {
  const EmailNotVerifiedState();

  @override
  List<Object> get props => [];
}
class CheckEmailVerificationState extends AuthState {
  const CheckEmailVerificationState();

  @override
  List<Object> get props => [];
}
