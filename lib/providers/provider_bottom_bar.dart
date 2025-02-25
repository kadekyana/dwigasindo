import 'package:dwigasindo/views/menus/menu_home.dart';
import 'package:dwigasindo/views/menus/menu_notifikasi.dart';
import 'package:dwigasindo/views/menus/menu_preferences.dart';
import 'package:dwigasindo/views/menus/menu_report.dart';
import 'package:flutter/material.dart';

class ProviderBottomBar extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> pages = [
    const MenuHome(),
    const MenuReport(),
    const MenuNotifikasi(),
    const MenuPreferences(),
  ];
}
