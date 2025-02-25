import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';

class ComponentApproval extends StatefulWidget {
  const ComponentApproval({super.key});

  @override
  State<ComponentApproval> createState() => _ComponentApprovalState();
}

class _ComponentApprovalState extends State<ComponentApproval> {
  // Data untuk setiap kategori
  final List<bool> listPoData = [true, true]; // Data untuk "List PO"
  final List<bool> listSpbData = [false]; // Data untuk "List SPB"
  final List<bool> historyData = []; // Data untuk "History" (opsional)

  // Variabel untuk menyimpan data yang ditampilkan
  List<bool> displayedData = [];

  @override
  void initState() {
    super.initState();
    // Default ke "List PO"
    displayedData = listPoData;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Approval',
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
            onPressed: () async {},
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
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
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
                  SizedBox(
                    width: width * 0.02,
                  ),
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
                  // Perbarui data berdasarkan kategori yang dipilih
                  setState(() {
                    if (index == 0) {
                      displayedData = listPoData;
                    } else if (index == 1) {
                      displayedData = listSpbData;
                    } else {
                      displayedData = historyData;
                    }
                  });
                  print('DATA KLIK : $value - $index - $isSelected');
                },
                buttons: const ['List PO', 'List SPB', 'History'],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedData.length,
                itemBuilder: (context, index) {
                  final data = displayedData[index];
                  return Container(
                    width: double.maxFinite,
                    height: height * 0.20,
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
                                    '27 Sep 2024',
                                    style: titleText,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  color: (data == true)
                                      ? SECONDARY_COLOR
                                      : Colors.grey.shade500,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: FittedBox(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (data == true)
                                        ? "Approve"
                                        : "Menunggu Approve",
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
                                SizedBox(
                                  height: 20,
                                  child: Row(
                                    children: [
                                      const Expanded(child: SizedBox.shrink()),
                                      const Expanded(child: SizedBox.shrink()),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/approve4.svg',
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/1.svg',
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/2.svg',
                                            ),
                                            const SizedBox(
                                              width: 5,
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
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        child: const FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Kode Permintaan',
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        child: const FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(': 2324253',
                                              style: subtitleTextBlack),
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: SizedBox.shrink()),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: const FittedBox(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Divisi',
                                              style: subtitleTextBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                                      const Expanded(child: SizedBox.shrink()),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: const FittedBox(
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
                                          padding: const EdgeInsets.all(3),
                                          child: const FittedBox(
                                            alignment: Alignment.centerLeft,
                                            child: Text(': Bahan Baku',
                                                style: subtitleTextBlack),
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox.shrink()),
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
                                padding: const EdgeInsets.all(6),
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
                                    bottom: height * 0.005,
                                    right: width * 0.01),
                                child: WidgetButtonCustom(
                                    FullWidth: width * 0.3,
                                    FullHeight: 25,
                                    title: "Lihat Barang",
                                    onpressed: () {},
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent),
                              ),
                            ],
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
