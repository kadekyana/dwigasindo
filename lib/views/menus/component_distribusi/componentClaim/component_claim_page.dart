import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentClaim/component_claim_list.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentClaimPage extends StatelessWidget {
  const ComponentClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.modelSummaryClaims?.data;
    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'List Tabung Claim'},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Maintenance',
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Container(
              width: width,
              height: 80.h,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 90.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Text(
                      "Jumlah\nTabung Claim\n${data?.totalClaim}",
                      style: subtitleTextBlack,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Container(
                    width: 90.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Text(
                      "Return Customer\n${data?.totalReturnCustomer}",
                      style: subtitleTextBlack,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
            ),
            Expanded(
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
                        await Future.wait([provider.getClaimsAll(context, 0)]);

                        // Navigate sesuai kondisi
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentClaimList(
                              title: 'List Maintenance',
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
                              offset: const Offset(0, 3),
                              color: Colors.grey.shade300),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/distribusi.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(item['title'], // Gunakan title dari list
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
          ],
        ),
      ),
    );
  }
}
