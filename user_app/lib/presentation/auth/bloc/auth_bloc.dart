import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/common/helper_function/http_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthSignInInitialState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSignInEvent>(authSignInEvent);
    on<AuthSignInNormalEvent>(authSignInNormalEvent);
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignInLoadingState());
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      log("yha");
      final response = await request('post', 'user/signin',
          json: {"email": event.email, "password": event.password});

      /**eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoiZ0BrLmNvbSIsImlhdCI6MTczMzUwNTk3MiwiZXhwIjoxNzMzNTA5NTcyfQ.3P_ROnr4WGEmnss28uoOYW5awiVaZEYkV1e7I19bJM0 */
      if (response.statusCode == 403) {
        emit(AuthSignInNotVerifiedUserState());
        return;
      } else if (response.statusCode == 200) {
        emit(AuthSignInSuccessState());
        return;
      }
      emit(AuthSignInFailureState());
      return;
    } catch (err) {
      log(err.toString());
      throw Error();
    }
  }

  FutureOr<void> authSignInNormalEvent(
      AuthSignInNormalEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthSignInInitialState());
    } catch (err) {
      return;
    }
  }
}
