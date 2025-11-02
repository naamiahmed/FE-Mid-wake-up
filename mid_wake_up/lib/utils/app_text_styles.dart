import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1({
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.bold,
  }) =>
      TextStyle(
        fontSize: 32,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h2({
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.bold,
  }) =>
      TextStyle(
        fontSize: 24,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h3({
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      TextStyle(
        fontSize: 20,
        fontWeight: fontWeight,
        color: color,
      );

  // Body Text
  static TextStyle bodyLarge({
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      TextStyle(
        fontSize: 16,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodyMedium({
    Color color = AppColors.textSecondary,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      TextStyle(
        fontSize: 14,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodySmall({
    Color color = AppColors.textLight,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      TextStyle(
        fontSize: 12,
        fontWeight: fontWeight,
        color: color,
      );

  // Button Text
  static TextStyle button({
    Color color = AppColors.white,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      TextStyle(
        fontSize: 16,
        fontWeight: fontWeight,
        color: color,
      );
}

