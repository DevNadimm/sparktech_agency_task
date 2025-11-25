import 'package:flutter/material.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/utils/themes/app_bar_theme.dart';
import 'package:sparktech_agency_task/core/utils/themes/elevated_button_theme.dart';
import 'package:sparktech_agency_task/core/utils/themes/input_decoration_theme.dart';
import 'package:sparktech_agency_task/core/utils/themes/outline_button_theme.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
);
