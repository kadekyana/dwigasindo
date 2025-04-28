import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                height: 130.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Column(
                  children: [
                    // name user login
                    SizedBox(
                      width: double.maxFinite,
                      height: 30.h,
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
                      height: 10.h,
                    ),
                    // card notifications
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/notif.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    height: 20.h,
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
                                    height: 25.h,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Info Tugas',
                                        style: titleText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 15.h,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Lihat Detail',
                                        style: titleText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  ClipOval(
                                    child: Container(
                                      width: 20.w,
                                      height: 20.h,
                                      color: Colors.white,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '5',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                                providerDistribusi.getAllTube(context),
                                providerDistribusi.getAllTubeGrade(context),
                                providerDistribusi.getAllTubeType(context),
                                providerDistribusi.getAllTubeGas(context),
                                providerDistribusi.getAllCostumer(context),
                                providerDistribusi.getAllSupplier(context),
                                providerDistribusi.getAllCradle(context),
                              ]);

                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuDistribusi(),
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
                                providerItem.getAllLocation(context),
                                providerSales.getSummaryOrder(context),
                                providerSales.getMasterProduk(context),
                                providerSales.getMasterProdukTrash(context),
                                providerDistribusi.getAllTubeGrade(context),
                                providerDistribusi.getAllCostumer(context),
                                providerItem.getAllVendor(context),
                                providerSales.getDocumentationCMD(
                                    context, 2 ?? 0),
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
