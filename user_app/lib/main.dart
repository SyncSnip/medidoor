import 'package:flutter/material.dart';
import 'package:user_app/config/theme/app_theme.dart';

import 'presentation/auth/pages/signup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SignupPage(), // Changed from RedirectingPage to SplashScreen
    );
  }
}
