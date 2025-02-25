import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double adaptiveFontSize(double size) {
  return size.sp.clamp(size * 0.8, size * 1.2);
}

TextStyle superTitleTextWhite = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(16),
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle superTitleTextBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(16),
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle titleText = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(14),
    fontWeight: FontWeight.w700,
    color: Colors.white);

TextStyle titleTextBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(14),
    fontWeight: FontWeight.w700,
    color: Colors.black);

TextStyle titleTextNormal = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: Colors.black);

TextStyle titleTextNormalWhite = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: Colors.white);

TextStyle subtitleText = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(12),
    fontWeight: FontWeight.w500,
    color: Colors.white);

TextStyle subtitleTextBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(12),
    fontWeight: FontWeight.w500,
    color: Colors.black);

TextStyle subtitleTextRed = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.red);

TextStyle minisubtitleTextNormal = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade400);

TextStyle subtitleTextGreen = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.green);

TextStyle subtitleTextBold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle minisubtitleTextBoldBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle subtitleTextBoldBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(12),
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle subtitleTextNormal = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(12),
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade400);

TextStyle subtitleTextNormalGrey = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade400);

TextStyle subtitleTextNormalwhite = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.white);

TextStyle subtitleTextNormalblack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.black);

TextStyle minisubtitleText = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.white);

TextStyle minisubtitleTextGrey = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade400);

TextStyle minisubtitleTextBlack = TextStyle(
    fontFamily: 'Manrope',
    fontSize: adaptiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: Colors.black);
