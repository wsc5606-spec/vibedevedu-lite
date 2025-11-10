import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// v2.3: VibeDev 타이포그래피
class VibeTypography {
  // Heading Styles
  static TextStyle h1({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: weight ?? FontWeight.bold,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle h2({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: weight ?? FontWeight.bold,
        color: color,
        letterSpacing: -0.3,
      );

  static TextStyle h3({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
        letterSpacing: -0.2,
      );

  static TextStyle h4({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
      );

  static TextStyle h5({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
      );

  static TextStyle h6({Color? color, FontWeight? weight}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
      );

  // Body Styles
  static TextStyle body1({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: weight ?? FontWeight.normal,
        color: color,
        height: 1.5,
      );

  static TextStyle body2({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.normal,
        color: color,
        height: 1.5,
      );

  static TextStyle body3({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: weight ?? FontWeight.normal,
        color: color,
        height: 1.4,
      );

  // Button Styles
  static TextStyle button({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
      );

  static TextStyle buttonSmall({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.w600,
        color: color,
        letterSpacing: 0.3,
      );

  // Caption & Label
  static TextStyle caption({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: weight ?? FontWeight.normal,
        color: color,
      );

  static TextStyle label({Color? color, FontWeight? weight}) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.w500,
        color: color,
        letterSpacing: 0.3,
      );

  // Code Style
  static TextStyle code({Color? color}) => GoogleFonts.firaCode(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle codeSmall({Color? color}) => GoogleFonts.firaCode(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color,
      );
}
