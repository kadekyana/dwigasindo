import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ComponentTambahSo extends StatefulWidget {
  ComponentTambahSo({super.key});

  @override
  State<ComponentTambahSo> createState() => _ComponentTambahSoState();
}

class _ComponentTambahSoState extends State<ComponentTambahSo> {
  // SingleSelectController<String?> tipe = SingleSelectController<String?>(null);
  SingleSelectController<String?> kategoriC =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> gudangC =
      SingleSelectController<String?>(null);

  TextEditingController keterangan = TextEditingController();

  late int selectWarehouse;
  late int selectKategori;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah SO',
        colorBG: Colors.grey.shade100,
        center: true,
        sizefont: 20,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: 110.h,
            child: ListTile(
              title: Text(
                'Keterangan',
                style: subtitleTextBlack,
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: height * 0.01),
                height: 70.h,
                child: TextField(
                  onChanged: (value) {},
                  maxLines: null,
                  expands: true,
                  controller: keterangan,
                  decoration: InputDecoration(
                    hintText: 'Masukkan keterangan di sini...',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  style: subtitleTextBlack,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.06,
              title: 'Simpan',
              onpressed: () async {
                if (keterangan.text.isNotEmpty) {
                  await provider.createSO(context, keterangan.text);
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Silahkan isi form dahulu',
                    ),
                  );
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ],
      ),
    );
  }
}
