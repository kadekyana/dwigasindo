import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/DaftarVendor/component_daftar_vendor.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/SPB/component_spb.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component_purchase.dart/Approval/component_approval.dart';
import 'component_purchase.dart/Purchase/component_purchase_order.dart';

class MenuPurchase extends StatelessWidget {
  const MenuPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Purchase',
        colorBack: Colors.black,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Total PO\n', style: titleText),
                          TextSpan(text: '10\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Total SPB\n', style: titleText),
                          TextSpan(text: '20\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const WidgetButtonDistribusi(
              title: 'Purchase Order',
              dataList: null,
              onTap: ComponentPurchaseOrder(),
            ),
            WidgetButtonDistribusi(
              title: 'Approval',
              dataList: null,
              onTap: ComponentApproval(),
            ),
            WidgetButtonDistribusi(
              title: 'SPB',
              dataList: null,
              onTap: ComponentSpb(),
            ),
            const WidgetButtonDistribusi(
              title: 'Daftar Vendor',
              dataList: null,
              onTap: ComponentDaftarVendor(),
            ),
          ],
        ),
      ),
    );
  }
}
