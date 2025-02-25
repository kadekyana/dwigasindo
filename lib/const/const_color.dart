// ignore_for_file: non_constant_identifier_names, constant_identifier_names, slash_for_doc_comments

import 'package:flutter/material.dart';

/**
 * Primary : warna utama yang digunakan pada app (appbar, button, dll)
 * Background : warna untuk background screen (splash, fullbackgroundcolor)
 * Complementary: warna komplementer yang selaras dengan primary dan background
 * Success: warna untuk menandakan berhasil (popup, button)
 * Gradient: kombinasi warna transisi
 * --------------------------------------------------------------------------------
 * Cara Pemakaian:
 * 1. import file const_color.dart di halaman yang akan digunakan
 * 2. ketikan nama const pada parameter color -->
 *    Text('Test', style: TextStyle(color: PRIMARY_COLOR,)),
 */

const PRIMARY_COLOR = Color(0xff11163E);
const SECONDARY_COLOR = Color(0xffEC3724);
const COMPLEMENTARY_COLOR1 = Color(0xff006198);
const COMPLEMENTARY_COLOR2 = Color(0xff34C759);
const COMPLEMENTARY_COLOR3 = Color(0xff32ADE6);
const COMPLEMENTARY_COLOR4 = Color(0xff2A9F47);
const COMPLEMENTARY_COLOR5 = Color(0xffFF9500);

// belum di set

const BUTTON_PRIMARY = Color(0xff407BFF);
final BACKGROUND_COLOR = Colors.teal.shade600;
const SUCCESS_COLOR = Color.fromARGB(255, 10, 137, 52);
const FAILED_COLOR = Color.fromARGB(255, 194, 14, 14);
const WARNING_COLOR = Color.fromARGB(255, 255, 206, 12);

LinearGradient gradientPrimary = const LinearGradient(
  colors: [Color(0xff11163E), Color(0x000000ff)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
LinearGradient gradientTeal = const LinearGradient(
  colors: [Color.fromARGB(255, 17, 193, 146), Color.fromARGB(255, 3, 112, 94)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
