import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/SPB/component_detail_spb.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/SPB/component_tambah_spb.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentSpb extends StatefulWidget {
  const ComponentSpb({super.key});

  @override
  State<ComponentSpb> createState() => _ComponentSpbState();
}

class _ComponentSpbState extends State<ComponentSpb> {
  List<bool> check = [true, false];
  GroupButtonController controller = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    final data = provider.spb?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'SPB',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComponentTambahSpb(),
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
      body: Container(
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
                  controller: controller,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['List SPB', 'History']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  final dataCard = data?[index];
                  return Container(
                    width: double.maxFinite,
                    height: 165.h,
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
                                height: height * 0.05,
                                width: width * 0.3,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    providerSales.formatDate(
                                        dataCard!.createdAt.toString()),
                                    style: titleText,
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  color: (data == true)
                                      ? COMPLEMENTARY_COLOR2
                                      : Colors.grey.shade500,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    (data == true) ? "Approve" : "Menunggu",
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
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
                                      flex: 2,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Nomor SPB',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                    ),
                                    const Text(' : '),
                                    Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text('${dataCard.no}',
                                            style: subtitleTextBlack),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/approve4.svg',
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/1.svg',
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/2.svg',
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          (data == true)
                                              ? SvgPicture.asset(
                                                  'assets/images/approve3.svg',
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/approve1.svg',
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Kategori',
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                      const Text(' : '),
                                      Expanded(
                                        flex: 4,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              (dataCard.spbType == 0)
                                                  ? "Barang"
                                                  : "Jasa",
                                              style: subtitleTextBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Dibuat Oleh',
                                            style: subtitleTextNormal,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormal,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              '${dataCard.createdByName}',
                                              style: subtitleTextNormal),
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, bottom: 5.h),
                            child: WidgetButtonCustom(
                                FullWidth: width,
                                FullHeight: 50.h,
                                title: "Lihat Barang",
                                onpressed: () async {
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
                                      provider.getDetailSPB(
                                          context, dataCard.no!),
                                    ]);

                                    // Navigate sesuai kondisi
                                    Navigator.of(context)
                                        .pop(); // Tutup Dialog Loading
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentDetailSpb(),
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
                                color: Colors.transparent),
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
    );
  }
}
