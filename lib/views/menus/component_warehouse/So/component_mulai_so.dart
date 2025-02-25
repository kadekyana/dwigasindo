import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'component_selesai_so.dart';

class ComponentMulaiSo extends StatefulWidget {
  ComponentMulaiSo({super.key, required this.id});
  int id;
  @override
  State<ComponentMulaiSo> createState() => _ComponentMulaiSoState();
}

class _ComponentMulaiSoState extends State<ComponentMulaiSo> {
  // Fungsi untuk menampilkan modal dialog
  SingleSelectController<Object?>? kategoriController =
      SingleSelectController<Object?>(null);
  SingleSelectController<Object?>? gudangController =
      SingleSelectController<Object?>(null);

  List<int>? category;
  int warehouse = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Stok Opname',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Consumer<ProviderItem>(
              builder: (context, provider, child) {
                final item = provider.allcategory?.data
                    .map((data) => {'id': data.id, 'name': data.name})
                    .toList();
                print(item);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: CustomDropdown(
                    controller: kategoriController,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
                        expandedBorder:
                            Border.all(color: Colors.grey.shade400)),
                    hintText: 'Pilih item',
                    items: item?.map((e) => e['name']).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        final ID =
                            item!.firstWhere((item) => item['name'] == value);
                        setState(() {
                          category = [int.parse(ID['id'].toString())];
                        });
                      } else {
                        print(value);
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Consumer<ProviderItem>(
              builder: (context, provider, child) {
                final item = provider.warehouse?.data
                    .map((data) => {'id': data.id, 'name': data.name})
                    .toList();
                print(item);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: CustomDropdown(
                    controller: gudangController,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
                        expandedBorder:
                            Border.all(color: Colors.grey.shade400)),
                    hintText: 'Pilih item',
                    items: item?.map((e) => e['name']).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        final ID =
                            item!.firstWhere((item) => item['name'] == value);
                        setState(() {
                          warehouse = int.parse(ID['id'].toString());
                        });
                      } else {
                        print(value);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: WidgetButtonCustom(
          title: "Lihat",
          color: PRIMARY_COLOR,
          bgColor: PRIMARY_COLOR,
          FullWidth: width,
          FullHeight: 40.h,
          onpressed: () async {
            print(category);
            print(warehouse);
            await provider.getDetailSO(
                context, category!, warehouse, widget.id);
          },
        ),
      ),
    );
  }
}
