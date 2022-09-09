part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStartedEvent extends AuthEvent {
  const AuthStartedEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailEvent extends AuthEvent {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class CheckEmailVerificationEvent extends AuthEvent {
  const CheckEmailVerificationEvent();

  @override
  List<Object> get props => [];
}
