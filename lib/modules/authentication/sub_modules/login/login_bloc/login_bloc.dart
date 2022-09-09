// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitial()) {
    on<AttemptLoginEvent>(_mapAttemptLoginEventToState);
    on<LoginFailedEvent>(_mapLoginFailedEventToState);
  }
  final UserRepository _userRepository;

  _mapAttemptLoginEventToState(
      AttemptLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(AttemptLoginState());
      await _userRepository.signInWithCredentials(
        email: event.email,
        password: event.password,
      );
      if (await _userRepository.confirmVerification()) {
        try {
          await _userRepository.getRiderDocument();
          return emit(LoginEmailVerifiedState());
        } catch (e) {
          return emit(LoginFailedState());
        }
      } else {
        try {
          await _userRepository.verifyAccount();
          return emit(LoginEmailNotVerifiedState());
        } catch (e) {
          return emit(LoginFailedState());
        }
      }
    } catch (err) {
      return emit(LoginFailedState());
    }
  }

  _mapLoginFailedEventToState(
      LoginFailedEvent event, Emitter<LoginState> emit) {
    return emit(LoginFailedState());
  }
}
