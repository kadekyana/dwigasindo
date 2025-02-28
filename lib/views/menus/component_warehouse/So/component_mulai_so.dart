import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart' as multi;
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
  SingleSelectController<Object?>? kategoriController1 =
      SingleSelectController<Object?>(null);
  SingleSelectController<Object?>? gudangController =
      SingleSelectController<Object?>(null);

  multi.MultiSelectController<int> controllerD =
      multi.MultiSelectController<int>();

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
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Consumer<ProviderItem>(
              builder: (context, provider, child) {
                final item = provider.allcategory?.data
                    .map((data) =>
                        multi.DropdownItem(label: data.name, value: data.id))
                    .toList();

                print(item);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: multi.MultiDropdown<int>(
                    items: item!,
                    controller: controllerD,
                  ),
                  // child: CustomDropdown(
                  //   controller: kategoriController,
                  //   decoration: CustomDropdownDecoration(
                  //       closedBorder: Border.all(color: Colors.grey.shade400),
                  //       expandedBorder:
                  //           Border.all(color: Colors.grey.shade400)),
                  //   hintText: 'Pilih Kategori',
                  //   items: item?.map((e) => e['name']).toList(),
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       final ID =
                  //           item!.firstWhere((item) => item['name'] == value);
                  //       setState(() {
                  //         category = [int.parse(ID['id'].toString())];
                  //       });
                  //     } else {
                  //       print(value);
                  //     }
                  //   },
                  // ),
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
                    hintText: 'Pilih Gudang',
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
            print(widget.id);
            print(category);
            print(warehouse);
            print(controllerD.selectedItems.map((e) => e.value));
            final tes = await provider.getDetailSO(
                context,
                controllerD.selectedItems.map((e) => e.value).toList(),
                warehouse,
                widget.id);
            if (tes == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComponentSelesaiSo(
                    id: widget.id,
                    warehouse_id: warehouse,
                    categori_id:
                        controllerD.selectedItems.map((e) => e.value).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
