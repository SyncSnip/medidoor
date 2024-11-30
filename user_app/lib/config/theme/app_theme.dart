// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:learn_blog/core/config/theme/app_color.dart';

// class AppTheme {
//   static final ThemeData lightTheme = ThemeData(
//     // primaryColor: AppColors.appWhite,
//     // scaffoldBackgroundColor: AppColors.appWhite,
//     brightness: Brightness.light,
//     // fontFamily: GoogleFonts.handlee().fontFamily,
//     fontFamily: GoogleFonts.openSans().fontFamily,
//   );
//   static final ThemeData darkTheme = ThemeData(
//     // primaryColor: AppColors.black,
//     // scaffoldBackgroundColor: AppColors.black,
//     brightness: Brightness.light,
//     fontFamily: GoogleFonts.handlee().fontFamily,
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/config/theme/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: GoogleFonts.nunito().fontFamily,
    
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.lightText,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightText,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        color: AppColors.lightText,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.lightSecondaryText,
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.lightBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: GoogleFonts.nunito().fontFamily,
    
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        color: AppColors.darkText,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.darkSecondaryText,
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
