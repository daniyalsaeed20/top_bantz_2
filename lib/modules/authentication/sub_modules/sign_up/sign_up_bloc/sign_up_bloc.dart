// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpCredentialsEvent>(_mapSignUpCredentialsEventToState);
  }
  final UserRepository _userRepository;
  _mapSignUpCredentialsEventToState(
      SignUpCredentialsEvent event, Emitter<SignUpState> emit) async {
    try {
      UserModel riderModel = UserModel(
          email: event.email,
          userName: event.fullName,
          contactNumber: event.contactNumber,
          dateOfBirth: event.contactNumber,
          userId: '');
      emit(
        SignUpCreateAccountProcessState(),
      );
      await _userRepository.registerWithCredentials(
        userModel: riderModel,
        password: event.password,
      );
      await _userRepository.verifyAccount();
      return emit(
        SignUpCredentialsState(
          password: event.password,
          userModel: riderModel,
        ),
      );
    } catch (e) {
      emit(SignUpInitial());
    }
  }
}
