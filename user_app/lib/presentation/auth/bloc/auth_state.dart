part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

// * auth sign in state

class AuthSignInInitialState extends AuthState {}

class AuthSignInLoadingState extends AuthState {}

class AuthSignInSuccessState extends AuthState {}

class AuthSignInFailureState extends AuthState {}

class AuthSignInNotVerifiedUserState extends AuthState {}

// * auth sign up state

class AuthSignUpInitialState extends AuthState {}

class AuthSignUpLoadingState extends AuthState {}

class AuthSignUpSuccessState extends AuthState {}

class AuthSignUpFailureState extends AuthState {}
