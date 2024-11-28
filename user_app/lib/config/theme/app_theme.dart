import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:learn_blog/core/config/theme/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // primaryColor: AppColors.appWhite,
    // scaffoldBackgroundColor: AppColors.appWhite,
    brightness: Brightness.light,
    // fontFamily: GoogleFonts.handlee().fontFamily,
    fontFamily: GoogleFonts.openSans().fontFamily,
  );
  static final ThemeData darkTheme = ThemeData(
    // primaryColor: AppColors.black,
    // scaffoldBackgroundColor: AppColors.black,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.handlee().fontFamily,
  );
}
