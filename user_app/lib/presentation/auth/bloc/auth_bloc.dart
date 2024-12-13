import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthSignInInitialState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSignInEvent>(authSignInEvent);
    on<AuthSignInNormalEvent>(authSignInNormalEvent);
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthSignUpNormalEvent>(authSignUpNormalEvent);
    on<AuthVerifyEmailOtpEvent>(authVerifyEmailOtpEvent);
    on<AuthVerifyEmailOtpNormalEvent>(authVerifyEmailOtpNormalEvent);
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignInLoadingState());
    try {
      final int sCode =
          await AuthRepository.signIn(event.email, event.password);

      log(sCode.toString());

      if (sCode == 403) {
        emit(AuthSignInNotVerifiedUserState());
        return;
      } else if (sCode == 200) {
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

  FutureOr<void> authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignUpLoadingState());
    try {
      final int sCode =
          await AuthRepository.signUp(event.email, event.password, event.name);

      log(sCode.toString());

      if (sCode == 201) {
        emit(AuthSignUpSuccessState());
        return;
      } else if (sCode == 400) {
        emit(AuthSignUpUserExistState());
        return;
      }
      emit(AuthSignUpFailureState());
      return;
    } catch (err) {
      log(err.toString());
      throw Error();
    }
  }

  FutureOr<void> authVerifyEmailOtpEvent(
      AuthVerifyEmailOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthVerifyEmailOtpLoadingState());
    try {
      final int sCode = await AuthRepository.verifyEmail(event.otp);

      log(sCode.toString());

      if (sCode == 200) {
        emit(AuthVerifyEmailOtpSuccessState());
        return;
      } else if (sCode == 404) {
        emit(AuthUserNotFoundOtpState());
        return;
      }
      emit(AuthVerifyEmailOtpFailureState());
      return;
    } catch (err) {
      log(err.toString());
      throw Error();
    }
  }

  FutureOr<void> authSignUpNormalEvent(
      AuthSignUpNormalEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthSignUpInitialState());
    } catch (err) {
      return;
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

  FutureOr<void> authVerifyEmailOtpNormalEvent(
      AuthVerifyEmailOtpNormalEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthVerifyEmailOtpInitialState());
      return;
    } catch (err) {
      return;
    }
  }
}
