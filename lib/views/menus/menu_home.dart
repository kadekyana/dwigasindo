import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/menus/component_produksi/menu_produksi.dart';
import 'package:dwigasindo/views/menus/menu_distribusi.dart';
import 'package:dwigasindo/views/menus/menu_purchase.dart';
import 'package:dwigasindo/views/menus/menu_warehouse.dart';
import 'package:dwigasindo/widgets/widget_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuHome extends StatelessWidget {
  MenuHome({super.key});

  @override
  Widget build(BuildContext context) {
    // inisiasi height dari layar
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final auth = Provider.of<ProviderAuth>(context);
    final dataUsers = auth.auth!.data;
    print(dataUsers.name);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite - kBottomNavigationBarHeight,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: height * 0.15,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.005),
                child: Column(
                  children: [
                    // name user login
                    SizedBox(
                      width: double.maxFinite,
                      height: 30,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hi ${dataUsers.name}',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // card notifications
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.015),
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/notif.png'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height * 0.02,
                                      child: const FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Notifikasi',
                                            style: subtitleText,
                                          )),
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height * 0.03,
                                      child: const FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Info Tugas',
                                            style: titleText,
                                          )),
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: width * 0.2,
                                          height: height * 0.02,
                                          child: const FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Lihat Detail',
                                                style: titleText,
                                              )),
                                        ),
                                        ClipOval(
                                          child: Container(
                                            width: width * 0.05,
                                            height: height * 0.025,
                                            color: Colors.white,
                                            child: const FittedBox(
                                                child: Text(
                                              '5',
                                              style: subtitleTextBlack,
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: double.maxFinite,
                                      height: 25,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  width: double.maxFinite,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    children: [
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/warehouse.png'),
                          isi: "Warehouse",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuWarehouse(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/distribusi.png'),
                          isi: "Distribusi",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuDistribusi(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Purchase",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuPurchase(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/produksi.png'),
                          isi: "Produksi",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuProduksi(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/produksi.png'),
                          isi: "Asset",
                          navigator: () async {}),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Order",
                          navigator: () async {}),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Sales",
                          navigator: () async {}),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Maintance",
                          navigator: () async {}),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Laporan",
                          navigator: () async {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
