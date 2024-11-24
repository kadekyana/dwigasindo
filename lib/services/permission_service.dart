import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Fungsi untuk meminta izin kamera
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  // Fungsi untuk mengecek izin kamera
  static Future<void> checkCameraPermission(BuildContext context) async {
    bool granted = await requestCameraPermission();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera permission is required to scan QR/Barcodes'),
        ),
      );
    }
  }
}
