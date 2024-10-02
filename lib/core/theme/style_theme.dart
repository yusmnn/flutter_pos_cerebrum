import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class StyleTheme {
  static ThemeData styleTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.purple.shade300),
      appBarTheme: AppBarTheme(
        color: AppColors.bgColor,
        titleTextStyle: GoogleFonts.quicksand(
          color: AppColors.primary,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.darkBlue,
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.black.withOpacity(0.05),
          ),
        ),
      ),
      scaffoldBackgroundColor: AppColors.bgColor,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 24,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        titleMedium: const TextStyle(
          fontSize: 18,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
        bodySmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.darkBlue,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.darkBlue,
        ),
        labelMedium: const TextStyle(
          color: AppColors.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
