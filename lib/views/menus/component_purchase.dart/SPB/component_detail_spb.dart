import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentDetailSpb extends StatefulWidget {
  const ComponentDetailSpb({super.key});

  @override
  State<ComponentDetailSpb> createState() => _ComponentDetailSpbState();
}

class _ComponentDetailSpbState extends State<ComponentDetailSpb> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    final data = provider.detailSpb?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Detail SPB',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.15,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kode SPB',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                data?.no ?? "-",
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tanggal',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                providerSales
                                    .formatDate(data!.spbDate.toString()),
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jenis SPB',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              (data.spbType == 0) ? "Barang" : "Jasa",
                              overflow: TextOverflow.ellipsis,
                              style: subtitleTextBlack,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Dibuat Oleh',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Text(
                            '${data.createdByName}',
                            style: subtitleTextBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: GroupButton(
                  isRadio: true,
                  controller: GroupButtonController(selectedIndex: 0),
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
            Expanded(
              child: (data.spbDetail?.length == 0)
                  ? const Center(
                      child: Text('Belum Terdapat Data'),
                    )
                  : ListView.builder(
                      itemCount: data.spbDetail?.length,
                      itemBuilder: (context, index) {
                        final dataCard = data.spbDetail![index];
                        return Container(
                          width: double.maxFinite,
                          height: 180.h,
                          padding: EdgeInsets.all(height * 0.01),
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
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/approve4.svg',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/approve3.svg',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'Nama Item',
                                                    style: subtitleTextBlack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      ': ${dataCard.itemName ?? "-"}',
                                                      style: subtitleTextBlack),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                                child: SizedBox.shrink()),
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
                                                      const EdgeInsets.all(5),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Qty',
                                                      style: subtitleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        ': ${dataCard.qty ?? "-"}',
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Spesifikasi',
                                                  style: titleTextBlack,
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
                              Expanded(
                                child: TextField(
                                  maxLines:
                                      null, // Membuat text field untuk teks panjang
                                  readOnly: true,
                                  expands:
                                      true, // Memperluas TextField agar sesuai dengan ukuran Container
                                  controller: TextEditingController(
                                      text: dataCard.specification),
                                  decoration: const InputDecoration(
                                    hintText: 'Masukkan keterangan di sini...',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: subtitleTextBlack,
                                  textAlignVertical: TextAlignVertical.top,
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
