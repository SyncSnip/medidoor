import 'package:flutter/material.dart';
import 'package:user_app/config/theme/app_theme.dart';
import 'package:user_app/redirecting_page.dart';

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
      themeMode: ThemeMode.system, // Will follow system theme
      home: const RedirectingPage(),
    );
  }
}
