import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';

OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: AppColors.buttonFontColor,
    side: const BorderSide(color: AppColors.inputBorderColor, width: 1.5),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    textStyle: GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.buttonFontColor,
        fontSize: 16,
        height: 1.2,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
