import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/data/sources/auth_source.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileSignOutEvent>(profileSignOutEvent);
    on<ProfileNormalEvent>(profileNormalEvent);
  }

  FutureOr<void> profileSignOutEvent(
      ProfileSignOutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileSignOutLoadingState());
    try {
      // Clear all stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(ProfileSignOutSuccessState());
      return;
    } catch (err) {
      emit(ProfileSignOutFailureState());
      return;
    }
  }

  FutureOr<void> profileNormalEvent(
      ProfileNormalEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial(name: AuthSource().getName));
    return;
  }
}
