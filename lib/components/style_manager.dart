import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toonify_app/components/font_constants.dart';


TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
    ) {
  return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle({
  double fontSize = 16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.sp,
    FontWeightManager.regular,
    color
  );
}

// medium style
TextStyle getMediumStyle({
  double fontSize = 16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.spMax,
    FontWeightManager.medium,
    color
  );
}

// medium style
TextStyle getLightStyle({
  double fontSize = 16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.sp,
    FontWeightManager.light,
    color
  );
}

// bold style
TextStyle getBoldStyle({
  double fontSize = 16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.spMax,
    FontWeightManager.bold,
    color
  );
}

// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = 16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.sp.spMax,
    FontWeightManager.semiBold,
    color
  );
}
