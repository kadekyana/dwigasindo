import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_data_crm.dart';
import 'package:dwigasindo/views/menus/component_sales/component_data_master_customer.dart';
import 'package:dwigasindo/views/menus/component_sales/component_data_sales_information.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSales extends StatelessWidget {
  const MenuSales({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerPro = Provider.of<ProviderOrder>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'Data Master Customer'},
      {'title': 'Sales Information'},
      {'title': 'CRM'},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Markening & Sales',
        colorBack: Colors.black,
        center: true,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorTitle: Colors.black,
        colorBG: Colors.grey.shade100,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index]; // Akses data dari list
            return GestureDetector(
              onTap: () async {
                // Tampilkan Dialog Loading
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
                    provider.getCMD(context),
                    providerItem.getAllItem(context),
                    provider.getSummarySales(context),
                    provider.getUsersPic(context),
                    providerPro.getMasterProduk(context),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  (item['title'] == "Data Master Customer")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentDataMasterCustomer(
                              title: item['title'],
                            ),
                          ),
                        )
                      : (item['title'] == "Sales Information")
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ComponentDataSalesInformation(
                                  title: item['title'],
                                ),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComponentDataCrm(
                                  title: item['title'],
                                ),
                              ),
                            );
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                height: height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 3),
                        color: Colors.grey.shade300),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/distribusi.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(item['title'], // Gunakan title dari list
                            style: titleTextBlack),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
