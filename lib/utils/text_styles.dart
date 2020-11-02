import 'dart:ui';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextStyles {
  TextStyles._();

  static const headingMedium = TextStyle(
      color: AppColors.greyishBrown,
      fontWeight: FontWeight.w500,
      fontFamily: 'Avenir-Medium',
      fontSize: 20.0);
  static const headingSmallMedium = TextStyle(
      color: Colors.black, fontWeight: FontWeight.w600, fontFamily: 'Avenir-Medium', fontSize: 18.0);
  static final TextStyle subtitleMedium = TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Avenir-Medium',
      fontSize: 16.0);
  static const body =
      TextStyle(color: AppColors.greyishBrown, fontFamily: 'Avenir-Medium', fontSize: 16.0);
}
