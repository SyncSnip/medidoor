part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {
  final String? name;

  ProfileInitialState({this.name});
}

class ProfileSignOutLoadingState extends ProfileState {}

class ProfileSignOutSuccessState extends ProfileState {}

class ProfileSignOutFailureState extends ProfileState {}
