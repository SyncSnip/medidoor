import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileSignOutEvent>(profileSignOutEvent);
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
}
