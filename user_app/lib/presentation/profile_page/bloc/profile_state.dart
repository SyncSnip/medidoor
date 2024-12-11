part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSignOutLoadingState extends ProfileState {}

class ProfileSignOutSuccessState extends ProfileState {}

class ProfileSignOutFailureState extends ProfileState {}
