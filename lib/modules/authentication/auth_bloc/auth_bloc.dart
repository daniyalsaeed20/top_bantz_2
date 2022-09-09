// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.userRepository,
  }) : super(AuthInitial()) {
    on<AuthStartedEvent>(_mapAuthStartedEventToState);
    on<VerifyEmailEvent>(_mapVerifyEmailEventToState);
    on<CheckEmailVerificationEvent>(_mapCheckEmailVerificationEventToState);
  }

  UserRepository userRepository;

  _mapAuthStartedEventToState(
      AuthStartedEvent event, Emitter<AuthState> emit) async {
    if (await userRepository.isSignedIn()) {
      try {
        emit(const AuthStartedState());
        await userRepository.getRiderDocument();
        return emit(const AuthSuccessState());
      } catch (e) {
        return emit(const AuthFailedState());
      }
    } else if (await userRepository.isSignedIn() == false) {
      return emit(const AuthFailedState());
    }
  }

  _mapVerifyEmailEventToState(VerifyEmailEvent event, Emitter<AuthState> emit) {
    userRepository.verifyAccount();
    return emit(const VerifyEmailState());
  }

  _mapCheckEmailVerificationEventToState(
      CheckEmailVerificationEvent event, Emitter<AuthState> emit) async {
    if (await userRepository.confirmVerification()) {
      await userRepository.getRiderDocument();
      return emit(const EmailVerifiedState());
    } else {
      return emit(const EmailNotVerifiedState());
    }
  }
}
