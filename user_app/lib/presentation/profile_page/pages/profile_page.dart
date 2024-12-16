import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/presentation/auth/pages/sign_in_page.dart';

import '../bloc/profile_bloc.dart';
import 'past_orders_page.dart'; // Import the PastOrdersPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileBloc profileBloc = ProfileBloc();

    return Scaffold(
      body: Stack(
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(500),
                        topRight: Radius.circular(500)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/w3images/avatar2.png'), // Updated to a working image from the internet
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Piyush Aggarwal',
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
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
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
                                    // Add your logout logic here
                                    // For example:
                                    // AuthService.logout();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInPage()));
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
