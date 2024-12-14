import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/splashscreen/pages/splashscreen.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profileBloc = ProfileBloc();

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        listener: (context, state) {
          if (state is ProfileSignOutSuccessState) {
            context.pushReplacement(const SplashScreen());
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
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
                Text(
                  state.name ?? 'User name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                if (state is ProfileSignOutLoadingState)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      _profileBloc.add(ProfileSignOutEvent());
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
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Order History'),
                  onTap: () {
                    // Navigate to Order History Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Manage Saved Address'),
                  onTap: () {
                    // Navigate to Manage Saved Address Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile'),
                  onTap: () {
                    // Navigate to Edit Profile Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About the App'),
                  onTap: () {
                    // Navigate to About the App Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Account Privacy'),
                  onTap: () {
                    // Navigate to Account Privacy Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Manage Transactions'),
                  onTap: () {
                    // Navigate to Manage Transactions Page
                  },
                ),
              ],
            );
          }
          return const Loading();
        },
      ),
    );
  }
}
