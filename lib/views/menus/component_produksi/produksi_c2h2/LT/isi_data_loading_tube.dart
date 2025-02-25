import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class IsiDataLoadingTube extends StatefulWidget {
  IsiDataLoadingTube({super.key, required this.title});
  String title;

  @override
  State<IsiDataLoadingTube> createState() => _IsiDataLoadingTubeState();
}

class _IsiDataLoadingTubeState extends State<IsiDataLoadingTube> {
  GroupButtonController? jenis = GroupButtonController(selectedIndex: 0);
  TextEditingController? nomorPo = TextEditingController();
  TextEditingController? namaPelanggan = TextEditingController();
  TextEditingController? jumlah = TextEditingController();
  TextEditingController? name = TextEditingController();
  bool check = true;
  int? selectTubeGas;
  List<Map<String, dynamic>>? tubeGas;

  bool selectJenis = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final provider = Provider.of<ProviderDistribusi>(context, listen: false);
  //   tubeGas = provider.tubeGas?.data
  //       .map((data) => {'id': data.id, 'name': data.name})
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Isi Data ${widget.title}',
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
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Pilih Jenis Isi Tabung',
                    style: titleTextBlack,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topCenter,
                    child: GroupButton(
                        controller: jenis,
                        isRadio: true,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                          if (index == 0) {
                            setState(() {
                              selectJenis = true;
                            });
                          } else {
                            setState(() {
                              selectJenis = false;
                            });
                          }
                        },
                        buttons: ['Massal', "Single"]),
                  ),
                ),
              ),
              if (widget.title == "Production")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text('Berat Kosong (Kg)', style: subtitleTextBlack),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: name,
                        alert: 'Harus Diisi',
                        hint: 'Contoh : 10',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              if (widget.title == "Production")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Cold Test',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Postfill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Cold Test',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Postfill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Status Ispeksi',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Production")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Test Bocor I (isi 50%)',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Production")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title:
                        Text('Berat CO2 (Isi 50%)', style: subtitleTextBlack),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: name,
                        alert: 'Harus Diisi',
                        hint: 'Contoh : 10',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Check Body',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Check Volve',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Vent',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                Container(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Hammer Test',
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
                          buttons: ['Good', "Not Good"]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: WidgetButtonCustom(
            FullWidth: width * 0.93,
            FullHeight: height * 0.06,
            title: (selectJenis == true) ? "Submit & Mulai Scan" : 'Submit',
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
