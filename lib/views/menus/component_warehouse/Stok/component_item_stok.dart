import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Stok/component_mutasi_stok.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool isButtonDisabled = false;
  GroupButtonController? list = GroupButtonController(selectedIndex: 0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderItem>(context, listen: false);
      provider.getAllItem(context);
      provider.getAllCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    print(provider.allItem?.data?.length);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              if (!mounted) return;

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
                  provider.getAllCategory(context),
                  provider.getAllLocation(context),
                  provider.getAllUnit(context),
                  provider.getAllVendor(context),
                ]);

                // Navigate sesuai kondisi
                Navigator.of(context).pop(); // Tutup Dialog Loading
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentTambahItem(),
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop(); // Tutup Dialog Loading
                print('Error: $e');
                // Tambahkan pesan error jika perlu
              }
            },
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: (provider.isLoading == true)
          ? Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: width,
              height: height,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
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
                        controller: list,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                        },
                        buttons: ['List Item']),
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
                                    // Header Row
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height * 0.05,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: height * 0.05,
                                            width: width * 0.3,
                                            decoration: const BoxDecoration(
                                              color: PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
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
                                              FullHeight: 30.h,
                                              title: 'Riwayat',
                                              onpressed: () {},
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Content Row
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 5.h, left: 10.w, right: 10.w),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center, // Tambahan
                                        children: [
                                          // Image Box
                                          Container(
                                            width: 90.w,
                                            height: 90.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: PRIMARY_COLOR,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          // Detail Column
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _buildRowDetail(
                                                    'Nama', data.name!),
                                                _buildRowDetail(
                                                    'Kode', data.code!),
                                                _buildRowDetail(
                                                    'Vendor', data.vendorName!),
                                                _buildRowDetail('Tersedia',
                                                    data.stock.toString()),
                                                _buildRowDetail('Dibuat oleh',
                                                    data.createdByName!),
                                                _buildRowDetail(
                                                  'Dibuat pada',
                                                  '${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Button Row
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          WidgetButtonCustom(
                                            FullWidth: 100.w,
                                            FullHeight: 30.h,
                                            title: 'Mutasi',
                                            onpressed: () async {
                                              if (!mounted) return;

                                              // Tampilkan Dialog Loading
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              );

                                              try {
                                                await Future.wait([
                                                  provider.getMutasi(
                                                      context, data.idStr!),
                                                ]);

                                                // Navigate sesuai kondisi
                                                Navigator.of(context)
                                                    .pop(); // Tutup Dialog Loading
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentMutasiStok(
                                                            vendor: data
                                                                .vendorName!,
                                                            nama: data.name!,
                                                            stokAda: data.stock
                                                                .toString(),
                                                            StokTakada: '100'),
                                                  ),
                                                );
                                              } catch (e) {
                                                Navigator.of(context)
                                                    .pop(); // Tutup Dialog Loading
                                                print('Error: $e');
                                                // Tambahkan pesan error jika perlu
                                              }
                                            },
                                            bgColor: PRIMARY_COLOR,
                                            color: Colors.transparent,
                                          ),
                                          WidgetButtonCustom(
                                            FullWidth: width * 0.3,
                                            FullHeight: 30.h,
                                            title: 'Penyesuaian',
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
                                            color: Colors.transparent,
                                          ),
                                          WidgetButtonCustom(
                                            FullWidth: width * 0.25,
                                            FullHeight: 30.h,
                                            title: 'Lihat',
                                            onpressed: () {},
                                            bgColor: PRIMARY_COLOR,
                                            color: Colors.transparent,
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
                      : Expanded(
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

Widget _buildRowDetail(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: (title != "Dibuat pada" && title != "Dibuat oleh")
                ? subtitleTextBlack
                : subtitleTextNormal,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            ': $value',
            style: (title != "Dibuat pada" && title != "Dibuat oleh")
                ? subtitleTextBlack
                : subtitleTextNormal,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
