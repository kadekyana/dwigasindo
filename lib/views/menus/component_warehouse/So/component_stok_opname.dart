import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'component_mulai_so.dart';

class ComponentStokOpname extends StatefulWidget {
  const ComponentStokOpname({super.key});

  @override
  State<ComponentStokOpname> createState() => _ComponentStokOpnameState();
}

class _ComponentStokOpnameState extends State<ComponentStokOpname> {
  String buttonText = "Mulai SO";
  Function? routeNav;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ComponentTambahItem(),
        //         ),
        //       );
        //     },
        //     icon: const Icon(
        //       Icons.add_circle_outline_rounded,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildListItem(index, width, height);
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
        isRadio: true,
        options: GroupButtonOptions(
          selectedColor: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        onSelected: (value, index, isSelected) {
          debugPrint('DATA KLIK: $value - $index - $isSelected');
        },
        buttons: ['List SO'],
      ),
    );
  }

  Widget _buildListItem(int index, double width, double height) {
    bool hideTanggal = index == 1 || index == 2;
    bool hideButton = index == 2;

    String buttonText;
    Function? routeNav;

    if (index == 1) {
      buttonText = "Lanjut SO";
      routeNav = () {};
    } else if (index == 2) {
      buttonText = "Lihat Data SO";
      routeNav = () {};
    } else {
      buttonText = "Mulai SO";
      routeNav = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComponentMulaiSo(),
          ),
        );
      };
    }

    return Container(
      width: double.infinity,
      height: height * 0.16,
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
          _buildListItemHeader(width, buttonText, routeNav),
          _buildListItemBody(width, hideTanggal, hideButton, height),
          _buildListItemFooter(width, buttonText, routeNav, height),
        ],
      ),
    );
  }

  Widget _buildListItemHeader(
      double width, String buttonText, Function? routeNav) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
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
                'SO-00003',
                style: titleText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: WidgetButtonCustom(
              FullWidth: width * 0.25,
              FullHeight: 30,
              title: 'Lihat Riwayat',
              onpressed: () {},
              bgColor: PRIMARY_COLOR,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemBody(
      double width, bool hideTanggal, bool hideButton, double height) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          children: [
            hideTanggal
                ? Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text('Tanggal', style: subtitleTextBlack),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(': 09 November 2024',
                                  style: subtitleTextBlack),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text('Keterangan', style: subtitleTextBlack),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (hideButton) ? 2 : 3,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        ': Lorem Ipsum adwadawdbadhbawudbadbaubdawu',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: height * 0.015,
                        ),
                      ),
                    ),
                  ),
                  hideButton
                      ? Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: height * 0.005,
                              right: width * 0.01,
                            ),
                            child: WidgetButtonCustom(
                              FullWidth: width * 0.15,
                              FullHeight: 30,
                              title: 'Berita Acara',
                              onpressed: () {},
                              bgColor: Colors.green.shade500,
                              color: Colors.transparent,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemFooter(
      double width, String buttonText, Function? routeNav, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.3,
            height: height * 0.02,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create by user 1",
                style: subtitleTextBlack,
              ),
            ),
          ),
          WidgetButtonCustom(
            FullWidth: width * 0.3,
            FullHeight: height * 0.05,
            title: buttonText,
            onpressed: routeNav!,
            bgColor: PRIMARY_COLOR,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
