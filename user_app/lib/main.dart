import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:user_app/config/theme/app_theme.dart';
import 'package:user_app/data/repository/cart_provider.dart';
import 'package:user_app/data/sources/auth_source.dart';
import 'package:user_app/presentation/splashscreen/pages/splashscreen.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    AuthSource().initialAuthSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
        ],
        builder: (context, child) => const SplashScreen(),
      ), // Changed from RedirectingPage to SplashScreen
    );
  }
}
