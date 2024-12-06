part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  AuthSignInEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class AuthSignOutEvent extends AuthEvent {}

class AuthForgotPasswordEvent extends AuthEvent {}

class AuthResetPasswordEvent extends AuthEvent {}

class AuthUpdatePasswordEvent extends AuthEvent {}

class AuthSignInNormalEvent extends AuthEvent {}
