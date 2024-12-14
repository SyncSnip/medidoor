import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/common/pages/no_internet_page.dart';
import 'package:user_app/config/config_files/local_storage_key.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/config/theme/app_color.dart';
import 'package:user_app/config/utils/internet_connectivity.dart';
import 'package:user_app/data/sources/auth_source.dart';
import 'package:user_app/presentation/auth/pages/sign_in_page.dart';
import 'package:user_app/redirecting_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  Future<void> _initializeApp() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String? token = pref.getString(AppKey().getTokenKey);
      final String? name = pref.getString(AppKey().getNameKey);
      final String? email = pref.getString(AppKey().getEmailKey);

      // Set auth data
      AuthSource()
        ..setToken = token ?? ''
        ..setName = name ?? ''
        ..setEmail = email ?? '';

      await Future.delayed(const Duration(seconds: 3));

      final bool isInternetAvailable =
          await InternetConnectivityManager.checkConnection();

      log(AuthSource().getName ?? "no name");
      log(AuthSource().getEmail ?? "no name");
      log(AuthSource().getToken ?? "no name");

      if (!mounted) return;
      log(isInternetAvailable.toString());

      // First check internet connection
      if (!isInternetAvailable) {
        context.pushReplacement(NoInternetPage(
          previousRoute: widget,
        ));
        return;
      }

      // Then check authentication
      if (token != null && token.isNotEmpty) {
        context.pushReplacement(const RedirectingPage());
      } else {
        context.pushReplacement(const SignInPage());
      }
    } catch (e) {
      debugPrint('Error in splash screen: $e');
      if (mounted) {
        context.pushReplacement(const SignInPage());
      }
    }
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo ya icon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // App name
                      const Text(
                        'MediDoor',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Tagline
                      const Text(
                        'Healthcare at your doorstep',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
