import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/Purchase/component_detail_po.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/Purchase/component_tambah_po.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentPurchaseOrder extends StatefulWidget {
  const ComponentPurchaseOrder({super.key});

  @override
  State<ComponentPurchaseOrder> createState() => _ComponentPurchaseOrderState();
}

class _ComponentPurchaseOrderState extends State<ComponentPurchaseOrder> {
  List<bool> check = [true, false];
  GroupButtonController controller = GroupButtonController(selectedIndex: 0);

  @override
  void initState() {
    super.initState();
    final providerItem = Provider.of<ProviderItem>(context, listen: false);
    providerItem.getAllPo(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    final item = providerItem.po?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Purchase Order',
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
                  provider.getCMD(context),
                  providerItem.getAllItem(context),
                  provider.getSummarySales(context),
                  provider.getUsersPic(context),
                  providerItem.getAllSPB(context),
                  providerItem.getAllCategory(context),
                  providerItem.getAllVendor(context),
                ]);

                // Navigate sesuai kondisi
                Navigator.of(context).pop(); // Tutup Dialog Loading
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentTambahPo(),
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop(); // Tutup Dialog Loading
                print('Error: $e');
                // Tambahkan pesan error jika perlu
              }
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                  controller: controller,
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['List SO', 'History']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: item?.length,
                itemBuilder: (context, index) {
                  final data = item?[index];
                  return Container(
                    width: double.maxFinite,
                    height: 180.h,
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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    (data?.createdAt != null)
                                        ? provider.formatDate(
                                            data!.createdAt.toString())
                                        : '-',
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
                                    (data?.picAcknowledgedStatus == 1 &&
                                            data?.picApprovedStatus == 1 &&
                                            data?.picVerifiedStatus == 1)
                                        ? "Approve"
                                        : (data?.picAcknowledgedStatus == 3 &&
                                                data?.picApprovedStatus == 3 &&
                                                data?.picVerifiedStatus == 3)
                                            ? "Reject"
                                            : "Menunggu",
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
                                          'Kode Permintaan',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                    ),
                                    const Text(': '),
                                    Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(data?.no ?? '-',
                                            style: subtitleTextBlack),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/approve4.svg',
                                            color: (data?.picAcknowledgedStatus ==
                                                    1)
                                                ? null
                                                : (data?.picAcknowledgedStatus ==
                                                        3)
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/1.svg',
                                            color: (data?.picApprovedStatus ==
                                                    1)
                                                ? null
                                                : (data?.picApprovedStatus == 3)
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/2.svg',
                                            color: (data?.picVerifiedStatus ==
                                                    1)
                                                ? null
                                                : (data?.picVerifiedStatus == 3)
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5.w,
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
                                            'Vendor',
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                      const Text(' : '),
                                      Expanded(
                                        flex: 4,
                                        child: Text(data?.vendorName ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextBlack),
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
                                          child: Text(data?.categoryName ?? '-',
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
                                              data?.createdByName ?? '-',
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
                                FullHeight: 40.h,
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
                                      providerItem.getDetailPurchase(
                                          context, data!.no!)
                                    ]);

                                    // Navigate sesuai kondisi
                                    Navigator.of(context)
                                        .pop(); // Tutup Dialog Loading
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentDetailPo(),
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
