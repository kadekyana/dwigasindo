import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_order.dart';
import 'package:dwigasindo/providers/provider_surat_jalan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ComponentBuatSuratJalan extends StatefulWidget {
  ComponentBuatSuratJalan({super.key});

  @override
  State<ComponentBuatSuratJalan> createState() =>
      _ComponentBuatSuratJalanState();
}

class _ComponentBuatSuratJalanState extends State<ComponentBuatSuratJalan> {
  int selectOrder = 0;

  SingleSelectController? controller = SingleSelectController(null);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderDistribusi>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    final providerSU = Provider.of<ProviderSuratJalan>(context);
    final data = providerItem.modelDataBpti?.data;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppbar(
        title: 'Buat Surat Jalan',
        sizefont: 15,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 90.h,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Consumer<ProviderItem>(
                        builder: (context, provider, child) {
                          final bptks = provider.order?.data
                              ?.map(
                                  (data) => {'id': data.id, 'name': data.code})
                              .toList();
                          return CustomDropdown(
                            controller: controller,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih Order',
                            items: bptks?.map((e) => e['name']).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                final ID = bptks?.firstWhere(
                                  (item) => item['name'] == value,
                                );
                                setState(() {
                                  selectOrder = int.parse(ID!['id'].toString());
                                });
                                print("Selected BPTK ID: $selectOrder");
                              } else {
                                print("BPTK is null");
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: width,
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomLeft,
                    child: Text('Pilih BPTI'),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final dataBpti = data?[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.01),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.1,
                              child: GestureDetector(
                                onTap: () {
                                  // Fungsi ini akan dipanggil ketika Card ditekan
                                  provider.onItemChanged(
                                    dataBpti.id.toString(),
                                    !provider.selectedItems.contains(dataBpti.id
                                        .toString()), // Cek status centang
                                    {
                                      'id': dataBpti.id,
                                      'no': dataBpti.no,
                                      'total': dataBpti.total,
                                    },
                                  );
                                },
                                child: Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  child: Row(
                                    children: [
                                      // Checkbox di sebelah kiri
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: height * 0.016,
                                            horizontal: width * 0.05,
                                          ),
                                          child: Row(
                                            children: [
                                              // Custom Checkbox
                                              Transform.scale(
                                                scale: 1.5,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: provider
                                                            .selectedItems
                                                            .contains(dataBpti!
                                                                .id
                                                                .toString())
                                                        ? COMPLEMENTARY_COLOR4 // Warna hijau ketika dipilih
                                                        : Colors.grey
                                                            .shade200, // Warna abu ketika tidak dipilih
                                                  ),
                                                  child: Checkbox(
                                                    value: provider
                                                        .selectedItems
                                                        .contains(dataBpti.id
                                                            .toString()),
                                                    onChanged: (bool? value) {
                                                      provider.onItemChanged(
                                                        dataBpti.id.toString(),
                                                        value ?? false,
                                                        {
                                                          'id': dataBpti.id,
                                                          'no': dataBpti.no,
                                                          'total':
                                                              dataBpti.total,
                                                        },
                                                      );
                                                    },
                                                    autofocus: true,
                                                    activeColor:
                                                        COMPLEMENTARY_COLOR4, // Warna ketika dipilih
                                                    checkColor:
                                                        COMPLEMENTARY_COLOR4, // Warna centang
                                                    shape: const CircleBorder(),
                                                    side: BorderSide(
                                                        color: Colors.grey
                                                            .shade200), // Bentuk bulat
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width * 0.03),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(dataBpti!.no!,
                                                    style: titleTextBlack),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 30,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.04),
                                            decoration: const BoxDecoration(
                                              color: PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "Total Tabung: ${dataBpti.total}",
                                                style: subtitleText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.005),
        child: WidgetButtonCustom(
          FullWidth: width,
          FullHeight: height * 0.065,
          title: 'Buat Surat Jalan',
          onpressed: () {
            WoltModalSheet.show(
              context: context,
              pageListBuilder: (bottomSheetContext) => [
                SliverWoltModalSheetPage(
                  topBarTitle: Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apakah kamu sudah yakin buat\nsurat jalan ?',
                            textAlign: TextAlign.center, style: titleTextBlack),
                        WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: height * 0.05,
                          title: 'Batal',
                          onpressed: () {
                            Navigator.pop(context);
                            print(provider.selectedItemsList);
                            provider
                                .clearSelectedItems(); // Menghapus item yang dipilih
                          },
                          color: SECONDARY_COLOR,
                          bgColor: SECONDARY_COLOR,
                        )
                      ],
                    ),
                  ),
                  isTopBarLayerAlwaysVisible: true,
                  navBarHeight: 150,
                  mainContentSliversBuilder: (context) => [
                    SliverList.builder(
                      itemCount: provider
                          .selectedItemsList.length, // Jumlah item yang dipilih
                      itemBuilder: (context, index) {
                        final selectedItem = provider.selectedItemsList[
                            index]; // Ambil item dari list yang dipilih
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              SizedBox(
                                height: height * 0.1,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.onItemChanged(
                                        "${selectedItem['id']}", // Perbaiki akses key sesuai dengan data
                                        !provider.selectedItems.contains(
                                            "${selectedItem['id']}"), // Pengecekan dengan id
                                        selectedItem);
                                  },
                                  child: Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.015,
                                              horizontal: width * 0.01,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: width * 0.01),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        selectedItem['no'],
                                                        style:
                                                            superTitleTextBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height: 30,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.04),
                                              decoration: const BoxDecoration(
                                                color: PRIMARY_COLOR,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Total Tabung: ${selectedItem['total']}",
                                                  style: subtitleText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: height * 0.05,
                          title: 'Buat Surat Jalan',
                          onpressed: () {
                            providerSU.createSuratJalan(context, selectOrder,
                                provider.selectedItemsList);
                          },
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          bgColor: PRIMARY_COLOR,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
