import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ComponentBuatSuratJalan extends StatelessWidget {
  const ComponentBuatSuratJalan({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderDistribusi>(context);

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
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 25,
                  width: width,
                  child: FittedBox(
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
                    itemCount: provider.data.length,
                    itemBuilder: (context, index) {
                      final dateData = provider.data[index];
                      final date = dateData['date'];
                      final items = dateData['items'];
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.01),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              width: width,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  date,
                                  style: titleTextBlack,
                                ),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, itemIndex) {
                                final item = items[itemIndex];
                                final itemId =
                                    "${date}-${item['tipe']}"; // Unique ID untuk setiap item

                                return SizedBox(
                                  height: height * 0.1,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Fungsi ini akan dipanggil ketika Card ditekan
                                      provider.onItemChanged(
                                          itemId,
                                          !provider.selectedItems
                                              .contains(itemId),
                                          item);
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
                                                                .contains(
                                                                    itemId)
                                                            ? COMPLEMENTARY_COLOR4 // Warna hijau ketika dipilih
                                                            : Colors.grey
                                                                .shade200, // Warna abu ketika tidak dipilih
                                                      ),
                                                      child: Checkbox(
                                                        value: provider
                                                            .selectedItems
                                                            .contains(itemId),
                                                        onChanged:
                                                            (bool? value) {
                                                          provider
                                                              .onItemChanged(
                                                                  itemId,
                                                                  value!,
                                                                  item);
                                                        },
                                                        autofocus: true,
                                                        activeColor:
                                                            COMPLEMENTARY_COLOR4, // Warna ketika dipilih
                                                        checkColor:
                                                            COMPLEMENTARY_COLOR4, // Warna centang
                                                        shape:
                                                            const CircleBorder(),
                                                        side: BorderSide(
                                                            color: Colors.grey
                                                                .shade200), // Bentuk bulat
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.03),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                            item['tipe'],
                                                            style:
                                                                titleTextBlack),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.4,
                                                        child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                                item['nama'])),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Total Tabung: ${item['total']}",
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
                                );
                              },
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
                              textAlign: TextAlign.center,
                              style: titleTextBlack),
                          WidgetButtonCustom(
                            FullWidth: width,
                            FullHeight: height * 0.05,
                            title: 'Batal',
                            onpressed: () {
                              Navigator.pop(context);
                              provider.clearSelectedItems();
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
                        itemCount: provider.selectedItemsList
                            .length, // Jumlah item yang dipilih
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
                                          "${selectedItem['tipe']}",
                                          !provider.selectedItems.contains(
                                              "${selectedItem['tipe']}"),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(selectedItem['tipe'],
                                                          style:
                                                              titleTextBlack),
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                            selectedItem[
                                                                'nama']),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
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
                        margin: EdgeInsets.all(15),
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: height * 0.05,
                          title: 'Buat Surat Jalan',
                          onpressed: () {},
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                      )),
                    ],
                  ),
                ],
              );
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
