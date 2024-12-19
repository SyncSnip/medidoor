import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/common/ui_functions/ui_functions.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/auth/pages/sign_in_page.dart';
import 'package:user_app/presentation/splashscreen/pages/splashscreen.dart';

import '../bloc/profile_bloc.dart';
import 'past_orders_page.dart'; // Import the PastOrdersPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void initState() {
    _profileBloc.add(ProfileNormalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        listener: (context, state) {
          if (state is ProfileSignOutSuccessState) {
            context.pushReplacement(const SplashScreen());
          } else if (state is ProfileSignOutFailureState) {
            errorPopup(
                ctx: context,
                head: "Logout Failed",
                body: "There was some error in logging you out");

            _profileBloc.add(ProfileNormalEvent());
          }
        },
        builder: (context, state) {
          if (state is ProfileInitialState) {
            return Stack(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Stack(
                        children: [
                          Container(
                            height: 800,
                            margin: const EdgeInsets.only(top: 50),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(500, 100),
                                topRight: Radius.elliptical(500, 100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                // backgroundImage: NetworkImage(
                                //     'https://www.w3schools.com/w3images/avatar2.png'), // Updated to a working image from the internet
                                backgroundImage: CachedNetworkImageProvider(
                                  'https://www.w3schools.com/w3images/avatar2.png',
                                ),
                              ),
                              const SizedBox(height: 10),
                              state.name == null
                                  ? const Loading()
                                  : Text(
                                      state.name!,
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              _buildProfileOptions(context),
                              const SizedBox(height: 20),
                              _buildAppSettings(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  width: double.infinity,
                  height: 100,
                  color: Colors.transparent,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        CircleAvatar(
                          backgroundColor: Colors.green[800],
                          child: IconButton(
                            icon: const Icon(Icons.power_settings_new,
                                color: Colors.white),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.green[50],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: Text(
                                      'Logout',
                                      style: GoogleFonts.lato(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to logout?',
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green[400],
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Logout',
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                        onPressed: () {
                                          _profileBloc
                                              .add(ProfileSignOutEvent());
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Loading();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Consultation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 3,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(Icons.edit, 'Edit Profile', () {
            // Navigate to Edit Profile Page
          }),
          _buildListTile(Icons.location_on, 'Manage Saved Address', () {
            // Navigate to Manage Saved Address Page
          }),
          _buildListTile(Icons.payment, 'Manage Transactions', () {
            // Navigate to Manage Transactions Page
          }),
          _buildListTile(Icons.history, 'Past Orders', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PastOrdersPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(Icons.settings, 'App Settings', () {
            // Navigate to App Settings Page
          }),
          SwitchListTile(
            title: Text(
              'App Theme',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            value: true,
            onChanged: (bool value) {
              // Handle theme change
            },
          ),
          SwitchListTile(
            title: Text(
              'Notifications',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            value: true,
            onChanged: (bool value) {
              // Handle notifications toggle
            },
          ),
          _buildListTile(Icons.lock, 'Account Privacy', () {
            // Navigate to Account Privacy Page
          }),
          _buildListTile(Icons.info, 'About the App', () {
            // Navigate to About the App Page
          }),
        ],
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
