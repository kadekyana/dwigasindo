import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentTambahProduksi extends StatefulWidget {
  const ComponentTambahProduksi({super.key});

  @override
  State<ComponentTambahProduksi> createState() =>
      _ComponentTambahProduksiState();
}

class _ComponentTambahProduksiState extends State<ComponentTambahProduksi> {
  String? selectCustomer;
  String? selectBptk;

  SingleSelectController<String?> bptk = SingleSelectController<String?>(null);
  SingleSelectController<String?> costumer =
      SingleSelectController<String?>(null);

  bool check = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Tambah C2H2',
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
            height: height * 0.1,
            child: ListTile(
              title: const Text(
                'Jenis Produksi*',
                style: titleTextBlack,
              ),
              subtitle: Align(
                alignment: Alignment.topLeft,
                child: GroupButton(
                    isRadio: true,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                    },
                    buttons: const ['PO', "Stokies"]),
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height * 0.1,
            child: ListTile(
              title: const Text(
                'Nomor PO',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: height * 0.01),
                child: WidgetForm(
                  alert: 'Nomor Po',
                  hint: '0012',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            width: width,
            height: height * 0.1,
            child: ListTile(
              title: const Text(
                'Nama Pelanggan',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: height * 0.01),
                child: WidgetForm(
                  alert: 'Nama Pelanggan',
                  hint: 'Nama Pelanggan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            width: width,
            height: height * 0.1,
            child: ListTile(
              title: const Text(
                'Jumlah Tabung',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: height * 0.01),
                child: WidgetForm(
                  alert: 'Jumlah Tabung',
                  hint: '100',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: WidgetButtonCustom(
            FullWidth: width * 0.93,
            FullHeight: height * 0.06,
            title: 'Submit',
            onpressed: () async {
              print("BPTK: ${selectBptk ?? 'Tidak Dipilih'}");
              print("Customer: ${selectCustomer ?? 'Tidak Dipilih'}");
              final selectA = (selectBptk != null)
                  ? int.parse(selectBptk.toString())
                  : null;
              final selectB = (selectCustomer != null)
                  ? int.parse(selectCustomer.toString())
                  : null;
              await provider.createBPTI(context, selectA, selectB);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
