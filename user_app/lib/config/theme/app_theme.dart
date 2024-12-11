import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/config/theme/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.secondaryLight,
    fontFamily: GoogleFonts.nunito().fontFamily,
    
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.secondary,
      onSurface: AppColors.textPrimary,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.secondaryLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.black,
    fontFamily: GoogleFonts.nunito().fontFamily,
    
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      surface: AppColors.secondary,
      onSurface: AppColors.white,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        color: AppColors.white,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
