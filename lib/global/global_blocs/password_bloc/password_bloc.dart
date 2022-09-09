// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial(obscureText: true)) {
    on<ShowPasswordEvent>(_mapShowPasswordEventToState);
    on<HidePasswordEvent>(_mapHidePasswordEventToState);
  }

  _mapShowPasswordEventToState(
      ShowPasswordEvent event, Emitter<PasswordState> emit) {
    return emit(ShowPasswordState(obscureText: event.obscureText));
  }

  _mapHidePasswordEventToState(
      HidePasswordEvent event, Emitter<PasswordState> emit) {
    return emit(HidePasswordState(obscureText: event.obscureText));
  }
}
