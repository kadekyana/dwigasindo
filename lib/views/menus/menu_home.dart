import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_order.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/menu_assets.dart';
import 'package:dwigasindo/views/menus/menu_distribusi.dart';
import 'package:dwigasindo/views/menus/menu_item_produksi.dart';
import 'package:dwigasindo/views/menus/menu_maintenance.dart';
import 'package:dwigasindo/views/menus/menu_order.dart';
import 'package:dwigasindo/views/menus/menu_purchase.dart';
import 'package:dwigasindo/views/menus/menu_sales.dart';
import 'package:dwigasindo/views/menus/menu_warehouse.dart';
import 'package:dwigasindo/widgets/widget_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuHome extends StatelessWidget {
  const MenuHome({super.key});

  @override
  Widget build(BuildContext context) {
    // inisiasi height dari layar
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final auth = Provider.of<ProviderAuth>(context);
    final dataUsers = auth.auth!.data;
    print(dataUsers.name);
    final providerSales = Provider.of<ProviderSales>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    final providerDistribusi = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Hi ${dataUsers.name}',
                          style: superTitleTextBlack,
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
                                      child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'Notifikasi',
                                            style: subtitleText,
                                          )),
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height * 0.03,
                                      child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
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
                                          child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              fit: BoxFit.scaleDown,
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
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
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
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            try {
                              await Future.wait([
                                providerItem.getAllWarehouse(context),
                                providerItem.getAllCategory(context),
                                providerItem.getAllItem(context),
                                providerItem.getAllCategory(context),
                                providerItem.getAllVendor(context),
                                providerItem.getPenerimaanBarang(context),
                                providerItem.getDataBpti(context),
                                providerDistribusi.getAllTube(context),
                                providerDistribusi.getAllTubeType(context),
                                providerDistribusi.getAllTubeGas(context),
                                providerDistribusi.getAllTubeGrade(context),
                                providerDistribusi.getAllCradle(context),
                                providerItem.getAllSO(context),
                                providerSales.getUsersPic(context),
                                providerItem.getAllPo(context),
                              ]);

                              // Navigate sesuai kondisi

                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuWarehouse(),
                                ),
                              );
                            } catch (e) {
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              print('Error: $e');
                              // Tambahkan pesan error jika perlu
                            }
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
                                builder: (context) => const MenuDistribusi(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Purchase",
                          navigator: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            try {
                              await Future.wait([
                                providerItem.getAllPo(context),
                                providerSales.getCMD(context),
                                providerItem.getAllItem(context),
                                providerSales.getSummarySales(context),
                                providerSales.getUsersPic(context),
                                providerItem.getAllSPB(context),
                                providerItem.getAllCategory(context),
                                providerItem.getAllVendor(context),
                                providerItem.getDataVendor(context),
                              ]);

                              // Navigate sesuai kondisi

                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuPurchase(),
                                ),
                              );
                            } catch (e) {
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              print('Error: $e');
                              // Tambahkan pesan error jika perlu
                            }
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
                                builder: (context) => const MenuItemProduksi(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/produksi.png'),
                          isi: "Asset",
                          navigator: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            try {
                              await Future.wait([
                                providerSales.getUsersPic(context),
                                providerSales.getAllOrder(context, 1),
                                providerItem.getAllItem(context),
                                providerSales.getSummaryOrder(context),
                                providerSales.getMasterProduk(context),
                                providerSales.getMasterProdukTrash(context),
                                providerDistribusi.getAllTubeGrade(context),
                                providerDistribusi.getAllCostumer(context),
                                providerItem.getAllVendor(context),
                              ]);

                              // Navigate sesuai kondisi
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuAssets(),
                                ),
                              );
                            } catch (e) {
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              print('Error: $e');
                              // Tambahkan pesan error jika perlu
                            }
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Order",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuOrder(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Sales",
                          navigator: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuSales(),
                              ),
                            );
                          }),
                      WidgetMenu(
                          HB: height,
                          FW: width,
                          icon: Image.asset('assets/images/purchase.png'),
                          isi: "Maintenance",
                          navigator: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            try {
                              await Future.wait([
                                // providerItem.getAllPo(context),
                                // providerSales.getCMD(context),
                                // providerItem.getAllItem(context),
                                // providerSales.getSummarySales(context),
                                // providerSales.getUsersPic(context),
                                // providerItem.getAllSPB(context),
                                // providerItem.getAllCategory(context),
                                // providerItem.getAllVendor(context),
                              ]);

                              // Navigate sesuai kondisi

                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuMaintenance(),
                                ),
                              );
                            } catch (e) {
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              print('Error: $e');
                              // Tambahkan pesan error jika perlu
                            }
                          }),
                      // WidgetMenu(
                      //     HB: height,
                      //     FW: width,
                      //     icon: Image.asset('assets/images/purchase.png'),
                      //     isi: "Laporan",
                      //     navigator: () async {}),
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
