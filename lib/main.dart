import 'package:dwigasindo/providers/provider_printer.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/provider_auth.dart';
import 'providers/provider_bottom_bar.dart';
import 'providers/provider_dashboard.dart';
import 'providers/provider_distribusi.dart';
import 'providers/provider_order.dart';
import 'providers/provider_scan.dart';
import 'providers/provider_surat_jalan.dart';
import 'providers/provider_item.dart';
import 'providers/provider_produksi.dart';
import 'views/menus/menu_splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions(); // Meminta izin saat aplikasi dijalankan
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // Meminta izin akses storage, kamera, dan lokasi
  await Permission.camera.request();
  await Permission.photos.request(); // Untuk akses galeri pada iOS
  await Permission.storage.request(); // Untuk akses penyimpanan pada Android
  await Permission.location.request(); // Untuk akses lokasi
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mendapatkan ukuran layar perangkat
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        // Cetak ukuran layar untuk debugging
        print("Screen Width: $screenWidth, Screen Height: $screenHeight");

        // Menyesuaikan ukuran desain berdasarkan kategori layar
        Size designSize;

        if (screenHeight >= 400 && screenHeight <= 600) {
          designSize = const Size(360, 560); // HP sangat kecil
        } else if (screenHeight >= 600 && screenHeight <= 800) {
          designSize = const Size(420, 760); // HP besar -- cukup
        } else {
          designSize = const Size(460, 960); // HP sangat besar
        }

        // Cetak ukuran desain yang digunakan
        print(
            "Using designSize: \t ${designSize.width} x \t ${designSize.height}");

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ProviderAuth()),
            ChangeNotifierProvider(create: (context) => ProviderBottomBar()),
            ChangeNotifierProvider(create: (context) => ProviderDashboard()),
            ChangeNotifierProvider(create: (context) => ProviderDistribusi()),
            ChangeNotifierProvider(create: (context) => ProviderScan()),
            ChangeNotifierProvider(create: (context) => ProviderSuratJalan()),
            ChangeNotifierProvider(create: (context) => ProviderItem()),
            ChangeNotifierProvider(create: (context) => ProviderProduksi()),
            ChangeNotifierProvider(create: (context) => ProviderOrder()),
            ChangeNotifierProvider(create: (context) => ProviderSales()),
            ChangeNotifierProvider(create: (context) => ProviderPrinter()),
          ],
          child: ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                home: MenuSplashScreen(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.linear(1.0)),
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
