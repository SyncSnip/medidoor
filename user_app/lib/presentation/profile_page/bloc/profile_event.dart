part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileSignOutEvent extends ProfileEvent {}

class ProfileNormalEvent extends ProfileEvent {}
