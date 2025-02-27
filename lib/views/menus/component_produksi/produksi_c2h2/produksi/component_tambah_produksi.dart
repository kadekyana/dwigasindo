import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentTambahProduksi extends StatefulWidget {
  ComponentTambahProduksi({super.key, required this.title});
  String title;

  @override
  State<ComponentTambahProduksi> createState() =>
      _ComponentTambahProduksiState();
}

class _ComponentTambahProduksiState extends State<ComponentTambahProduksi> {
  GroupButtonController? jenis = GroupButtonController();
  TextEditingController? nomorPo = TextEditingController();
  TextEditingController? namaPelanggan = TextEditingController();
  TextEditingController? jumlah = TextEditingController();
  TextEditingController? name = TextEditingController();
  bool check = true;
  int? selectTubeGas;
  List<Map<String, dynamic>>? tubeGas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ProviderDistribusi>(context, listen: false);
    tubeGas = provider.tubeGas?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Produksi',
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Jenis Produksi*',
                    style: titleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: GroupButton(
                        controller: jenis,
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
                  title: Text('Nama', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Nama',
                      hint: '23G2134',
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
                  title: Text('Nomor PO', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: nomorPo,
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
                  title: Text('Nama Pelanggan', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: namaPelanggan,
                      alert: 'Nama Pelanggan',
                      hint: 'Nama Pelanggan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              if (widget.title != "C2H2")
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Jenis Gas*',
                      style: subtitleTextBlack,
                    ),
                    subtitle: WidgetDropdown(
                      items: tubeGas!
                          .map((item) => item['name'].toString())
                          .toList(),
                      hintText: 'Tipe',
                      onChanged: (value) {
                        final selectedC = tubeGas!
                            .firstWhere((item) => item['name'] == value);
                        setState(() {
                          selectTubeGas = selectedC['id'];
                        });
                      },
                      controller: null,
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
                  title: Text('Jumlah Tabung', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: jumlah,
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
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: WidgetButtonCustom(
            FullWidth: width * 0.93,
            FullHeight: height * 0.06,
            title: 'Submit',
            onpressed: () async {
              (widget.title == 'C2H2')
                  ? await provider.createProduksi(
                      context,
                      jenis!.selectedIndex,
                      nomorPo!.text,
                      name!.text,
                      namaPelanggan!.text,
                      int.parse(jumlah!.text))
                  : await provider.createMixGas(
                      context,
                      jenis!.selectedIndex,
                      nomorPo!.text,
                      name!.text,
                      namaPelanggan!.text,
                      int.parse(jumlah!.text),
                      selectTubeGas);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
