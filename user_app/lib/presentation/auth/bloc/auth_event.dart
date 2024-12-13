part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });
  final String email;
  final String password;
  final String name;
}

class AuthSignInEvent extends AuthEvent {
  AuthSignInEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class AuthForgotPasswordEvent extends AuthEvent {}

class AuthResetPasswordEvent extends AuthEvent {}

class AuthUpdatePasswordEvent extends AuthEvent {}

class AuthSignInNormalEvent extends AuthEvent {}

class AuthSignUpNormalEvent extends AuthEvent {}

class AuthVerifyEmailOtpEvent extends AuthEvent {
  final String otp;

  AuthVerifyEmailOtpEvent({required this.otp});
}

class AuthVerifyEmailOtpNormalEvent extends AuthEvent {}
