import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/DaftarVendor/component_detail_data_vendor.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ComponentDaftarVendor extends StatefulWidget {
  const ComponentDaftarVendor({super.key});

  @override
  State<ComponentDaftarVendor> createState() => _ComponentDaftarVendorState();
}

class _ComponentDaftarVendorState extends State<ComponentDaftarVendor> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Daftar Vendor',
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  buttons: ['List Vendor']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  print(index);
                  return cardWidget(height: height, width: width);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cardWidget extends StatelessWidget {
  const cardWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height * 0.18,
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
          Container(
            width: double.maxFinite,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: width * 0.3,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '27 Sep 2024',
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
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nomor PO',
                              style: subtitleTextBlack,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child:
                                Text(': 198289-AD', style: subtitleTextBlack),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox.shrink()),
                    ],
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Vendor',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ': PT Lorem Ipsum',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: height * 0.02,
                                ),
                              ),
                            ),
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
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kategori',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(': Bahan Baku',
                                  style: subtitleTextBlack),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create by user 1',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: height * 0.005, right: width * 0.01),
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.3,
                      FullHeight: 25,
                      title: "Lihat Barang",
                      onpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentDetailDataVendor(),
                          ),
                        );
                      },
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
