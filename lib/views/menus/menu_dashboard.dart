import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/providers/provider_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Consumer<ProviderBottomBar>(
          builder: (BuildContext context, ProviderBottomBar provider,
              Widget? child) {
            return provider.pages[provider.currentIndex];
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Consumer<ProviderBottomBar>(
          builder: (BuildContext context, ProviderBottomBar provider,
              Widget? child) {
            return BottomBarBubble(
              backgroundColor: Colors.grey.shade100,
              color: PRIMARY_COLOR,
              selectedIndex: provider.currentIndex,
              items: [
                BottomBarItem(
                    iconBuilder: (color) => SvgPicture.asset(
                          'assets/images/h.svg',
                          width: 28,
                          height: 28,
                          color:
                              color, // Sesuaikan warna dengan yang diinginkan
                        ),
                    label: 'Beranda',
                    labelTextStyle: const TextStyle(fontSize: 12)),
                BottomBarItem(
                    iconBuilder: (color) => SvgPicture.asset(
                          'assets/images/b.svg',
                          width: 28,
                          height: 28,
                          color:
                              color, // Sesuaikan warna dengan yang diinginkan
                        ),
                    label: 'Laporan',
                    labelTextStyle: const TextStyle(fontSize: 12)),
                BottomBarItem(
                    iconBuilder: (color) => SvgPicture.asset(
                          'assets/images/d.svg',
                          width: 28,
                          height: 28,
                          color:
                              color, // Sesuaikan warna dengan yang diinginkan
                        ),
                    label: 'Notifikasi',
                    labelTextStyle: const TextStyle(fontSize: 12)),
                BottomBarItem(
                    iconBuilder: (color) => SvgPicture.asset(
                          'assets/images/f.svg',
                          width: 24,
                          height: 24,
                          color:
                              color, // Sesuaikan warna dengan yang diinginkan
                        ),
                    label: 'Pengaturan',
                    labelTextStyle: const TextStyle(fontSize: 12)),
              ],
              onSelect: (index) {
                Future.delayed(Duration.zero, () {
                  provider.setIndex(index);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
