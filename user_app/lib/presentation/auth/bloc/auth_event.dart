part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {}

class AuthSignOutEvent extends AuthEvent {}

class AuthForgotPasswordEvent extends AuthEvent {}

class AuthResetPasswordEvent extends AuthEvent {}

class AuthUpdatePasswordEvent extends AuthEvent {}
