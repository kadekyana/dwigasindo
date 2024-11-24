import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/providers/provider_bottom_bar.dart';
import 'package:dwigasindo/providers/provider_dashboard.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/providers/provider_surat_jalan.dart';
import 'package:dwigasindo/views/menus/menu_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'providers/provider_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions(); // Meminta izin saat aplikasi dijalankan
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // Meminta izin akses storage dan kamera
  await Permission.camera.request();
  await Permission.photos.request(); // Untuk akses galeri pada iOS
  await Permission.storage.request(); // Untuk akses penyimpanan pada Android
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderAuth(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderBottomBar(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderDashboard(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderDistribusi(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderScan(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderScan(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderSuratJalan(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderItem(),
        ),
      ],
      child: MaterialApp(
        // home: MenuSplashScreen(),
        home: MenuSplashScreen(),
      ),
    );
  }
}
