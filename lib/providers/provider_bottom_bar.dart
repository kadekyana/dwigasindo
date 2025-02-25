import 'dart:io';

import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_blast_keterangan.dart';
import 'package:dwigasindo/views/menus/menu_home.dart';
import 'package:dwigasindo/views/menus/menu_notifikasi.dart';
import 'package:dwigasindo/views/menus/menu_preferences.dart';
import 'package:dwigasindo/views/menus/menu_report.dart';
import 'package:dwigasindo/views/menus/menu_scan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProviderBottomBar extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> pages = [
    MenuHome(),
    MenuReport(),
    MenuNotifikasi(),
    MenuPreferences(),
  ];

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
