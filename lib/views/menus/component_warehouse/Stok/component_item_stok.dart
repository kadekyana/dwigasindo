import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Stok/component_mutasi_stok.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import '../../../../providers/provider_item.dart';
import 'component_penyesuaian_stok.dart';
import 'component_tambah_item.dart';

class ComponentItemStok extends StatefulWidget {
  const ComponentItemStok({super.key});

  @override
  State<ComponentItemStok> createState() => _ComponentItemStokState();
}

class _ComponentItemStokState extends State<ComponentItemStok> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderItem>(context, listen: false);
    provider.getAllItem(context);
    provider.getAllCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'List Item',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () async {
              final provider =
                  Provider.of<ProviderItem>(context, listen: false);
              await provider.getAllCategory(context);
              await provider.getAllLocation(context);
              await provider.getAllUnit(context);
              await provider.getAllVendor(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComponentTambahItem(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: (provider.isLoading == true)
          ? const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: height * 0.1,
                    child: Row(
                      children: [
                        // Search bar
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: WidgetForm(
                              alert: 'Search',
                              hint: 'Search',
                              border: InputBorder.none,
                              preicon: const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        // filter bar
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GroupButton(
                        isRadio: true,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                        },
                        buttons: const ['List Item']),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  (provider.allItem!.data!.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: provider.allItem!.data!.length,
                            itemBuilder: (context, index) {
                              final data = provider.allItem!.data![index];
                              return Container(
                                width: double.maxFinite,
                                height: height * 0.28,
                                margin: EdgeInsets.only(bottom: height * 0.02),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                      color: Color(0xffE4E4E4),
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: width * 0.3,
                                            decoration: const BoxDecoration(
                                              color: PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${provider.getCategory(2)}',
                                                style: titleText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: WidgetButtonCustom(
                                                FullWidth: width * 0.25,
                                                FullHeight: 30,
                                                title: 'Lihat Riwayat',
                                                onpressed: () {},
                                                bgColor: PRIMARY_COLOR,
                                                color: Colors.transparent),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: PRIMARY_COLOR,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child:
                                                              const FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Nama Item',
                                                              style:
                                                                  titleTextBlack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child: FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                ': ${data.name}',
                                                                style:
                                                                    titleTextBlack),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child:
                                                              const FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Kode Item',
                                                              style:
                                                                  titleTextBlack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child: FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                ': ${data.code}',
                                                                style:
                                                                    titleTextBlack),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child:
                                                              const FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Vendor',
                                                              style:
                                                                  titleTextBlack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          child: FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                ': ${data.vendorName}',
                                                                style:
                                                                    titleTextBlack),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            child:
                                                                const FittedBox(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                'Stok Tersedia',
                                                                style:
                                                                    titleTextBlack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            child: FittedBox(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  ': ${data.stock}',
                                                                  style:
                                                                      titleTextBlack),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Mutasi Stok',
                                              onpressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ComponentMutasiStok(),
                                                  ),
                                                );
                                                await provider.getMutasi(
                                                    context, data.idStr!);
                                              },
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent),
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.3,
                                              FullHeight: 30,
                                              title: 'Penyesuaian Stok',
                                              onpressed: () async {
                                                await provider
                                                    .getAllWarehouse(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentPenyesuaianStok(
                                                      itemId: data.id!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent),
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Lihat Data',
                                              onpressed: () {},
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Create by ${data.createdByName}',
                                                style: TextStyle(
                                                  fontFamily: 'Manrope',
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Date ${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                style: TextStyle(
                                                  fontFamily: 'Manrope',
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text('Data Kosong'),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
