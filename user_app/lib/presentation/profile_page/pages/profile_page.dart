import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/splashscreen/pages/splashscreen.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = ProfileBloc();

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is ProfileSignOutSuccessState) {
            context.pushReplacement(const SplashScreen());
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
              ),
              const SizedBox(height: 20),
              const Text(
                "User Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              if (state is ProfileSignOutLoadingState)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    profileBloc.add(ProfileSignOutEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
