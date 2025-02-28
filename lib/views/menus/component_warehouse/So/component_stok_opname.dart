import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_mulai_so.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_tambah_so.dart';
import 'package:dwigasindo/views/menus/menu_warehouse.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentStokOpname extends StatefulWidget {
  const ComponentStokOpname({super.key});

  @override
  State<ComponentStokOpname> createState() => _ComponentStokOpnameState();
}

class _ComponentStokOpnameState extends State<ComponentStokOpname> {
  bool isButtonDisabled = false;
  String buttonText = "Mulai SO";
  Function? routeNav;

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
          final provider = Provider.of<ProviderItem>(context, listen: false);
          setState(() {
            provider.cekLoad = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MenuWarehouse()));
        },
        actions: [
          IconButton(
            onPressed: isButtonDisabled
                ? null
                : () async {
                    setState(() {
                      isButtonDisabled = true; // Disable button
                    });

                    // Tampilkan loading
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    // Proses yang ingin Anda jalankan
                    await provider.getAllWarehouse(context);
                    await provider.getAllCategory(context);

                    // Tutup dialog loading
                    Navigator.pop(context);

                    // Navigasi ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComponentTambahSo(),
                      ),
                    );

                    // Enable kembali tombol jika perlu (opsional)
                    // setState(() {
                    //   isButtonDisabled = false;
                    // });
                  },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildSearchAndFilterBar(width, height),
            const SizedBox(height: 8),
            _buildGroupButton(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: provider.so!.data!.length,
                itemBuilder: (context, index) {
                  final data = provider.so!.data![index];
                  return Container(
                    width: double.infinity,
                    height: 150.h,
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
                        // Header
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.045,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.05,
                                width: width * 0.3,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    data.no ??
                                        '-', // Misalnya menggunakan `id` dari `data`
                                    style: titleText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Body
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8.w, top: 2.h),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Keterangan',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          ' : ',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(data.note ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: subtitleTextBlack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: Text(
                                              'Dibuat oleh ${data.createdBy ?? '-'}',
                                              style: subtitleTextNormal),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            "- ${provider.formatDate(data.createdAt.toString())}",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Footer
                        Container(
                          width: width,
                          height: 40.h,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: WidgetButtonCustom(
                            FullWidth: width,
                            FullHeight: 40.h,
                            title: "Lihat Stok Opaname",
                            onpressed: () async {
                              await provider.getLihatSO(context, data.id!);
                            },
                            color: PRIMARY_COLOR,
                            bgColor: PRIMARY_COLOR,
                          ),
                        )
                      ],
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

  Widget _buildSearchAndFilterBar(double width, double height) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.1,
      child: Row(
        children: [
          // Search bar
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(16),
              ),
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
          SizedBox(width: width * 0.02),
          // Filter bar
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GroupButton(
        controller: GroupButtonController(selectedIndex: 0),
        isRadio: true,
        options: GroupButtonOptions(
          selectedColor: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        onSelected: (value, index, isSelected) {
          debugPrint('DATA KLIK: $value - $index - $isSelected');
        },
        buttons: const ['List SO'],
      ),
    );
  }
}

class DetailLihatSO extends StatefulWidget {
  DetailLihatSO({super.key, required this.id});
  final int id;
  @override
  State<DetailLihatSO> createState() => _DetailLihatSOState();
}

class _DetailLihatSOState extends State<DetailLihatSO> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final data = provider.lihatSo!.data!;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Detail Stok Opname',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ComponentStokOpname()));
        },
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 40.h,
              child: WidgetButtonCustom(
                  FullWidth: width,
                  FullHeight: 40.h,
                  title: "Tambah Detail",
                  onpressed: () async {
                    print(widget.id);
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
                        provider.getAllWarehouse(context),
                        provider.getAllCategory(context),
                        provider.getAllItem(context),
                        provider.getAllCategory(context),
                        provider.getAllVendor(context),
                        provider.getAllSO(context),
                      ]);

                      // Navigate sesuai kondisi

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComponentMulaiSo(
                            id: widget.id,
                          ),
                        ),
                      );
                    } catch (e) {
                      Navigator.of(context).pop(); // Tutup Dialog Loading
                      print('Error: $e');
                      // Tambahkan pesan error jika perlu
                    }
                  },
                  color: PRIMARY_COLOR,
                  bgColor: PRIMARY_COLOR),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return Container(
                    width: double.maxFinite,
                    height: 300.h,
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
                          height: height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.3,
                                height: height * 0.05,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    dataCard.code ?? "-",
                                    style: titleText,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.3,
                                height: 50.sh,
                                decoration: BoxDecoration(
                                  color: (dataCard.status == 1)
                                      ? Colors.grey
                                      : (dataCard.status == 2)
                                          ? COMPLEMENTARY_COLOR2
                                          : SECONDARY_COLOR,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    (dataCard.status == 1)
                                        ? "Proses"
                                        : (dataCard.status == 2)
                                            ? "Selesai"
                                            : "Revisi",
                                    style: titleText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.025),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Gudang',
                                              style: subtitleTextBlack,
                                            ),
                                          ),
                                          SizedBox(
                                            child: Text(' : ',
                                                style: subtitleTextBlack),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                                dataCard.warehouseName ?? "-",
                                                style: subtitleTextBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        (dataCard.isProcessVerified == true)
                                            ? SvgPicture.asset(
                                                'assets/images/approve3.svg',
                                                width: 30.w,
                                                height: 20.h,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/approve1.svg',
                                                width: 30.w,
                                                height: 20.h,
                                              ),
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        (dataCard.isProcessApproval == true)
                                            ? SvgPicture.asset(
                                                'assets/images/approve3.svg',
                                                width: 30.w,
                                                height: 20.h,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/approve1.svg',
                                                width: 30.w,
                                                height: 20.h,
                                              ),
                                      ],
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Kategori',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(' : ',
                                                  style: subtitleTextBlack),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  dataCard.categories ?? "-",
                                                  style: subtitleTextBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 50.w,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Dibuat Oleh',
                                              style: subtitleTextNormal,
                                            ),
                                          ),
                                          SizedBox(
                                            child: Text(' : ',
                                                style: subtitleTextNormal),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                                dataCard.createdBy ?? "-",
                                                style: subtitleTextNormal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50.w,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: WidgetButtonCustom(
                                      FullWidth: width * 0.3,
                                      FullHeight: 30.h,
                                      title: "Lihat Barang",
                                      onpressed: () {},
                                      bgColor: Colors.grey,
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        if (dataCard.status == 3)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: WidgetButtonCustom(
                                        FullWidth: width * 0.3,
                                        FullHeight: 30.h,
                                        title: "Revisi",
                                        onpressed: () {
                                          provider.getApprovalVerifikasi(
                                              context, dataCard.id!, 3);
                                        },
                                        bgColor: SECONDARY_COLOR,
                                        color: Colors.transparent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: WidgetButtonCustom(
                                      FullWidth: width * 0.3,
                                      FullHeight: 30.h,
                                      title: "Approval Verifikasi",
                                      onpressed: (dataCard.isProcessVerified ==
                                              true)
                                          ? null
                                          : () {
                                              provider.getApprovalVerifikasi(
                                                  context, dataCard.id!, 1);
                                            },
                                      bgColor:
                                          (dataCard.isProcessVerified == true)
                                              ? Colors.grey
                                              : PRIMARY_COLOR,
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: WidgetButtonCustom(
                                      FullWidth: width * 0.3,
                                      FullHeight: 30.h,
                                      title: "Approval Mengetahui",
                                      onpressed: (dataCard.isProcessApproval ==
                                                  true ||
                                              dataCard.status == 3)
                                          ? null
                                          : () {
                                              provider.getApprovalVerifikasi(
                                                  context, dataCard.id!, 2);
                                            },
                                      bgColor:
                                          (dataCard.isProcessApproval == true ||
                                                  dataCard.status == 3)
                                              ? Colors.grey
                                              : PRIMARY_COLOR,
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
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
    );
  }
}
