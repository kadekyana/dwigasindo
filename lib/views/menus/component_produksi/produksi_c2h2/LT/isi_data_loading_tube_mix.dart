import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class IsiDataLoadingTubeMix extends StatefulWidget {
  IsiDataLoadingTubeMix({super.key, required this.title, required this.uuid});
  String title;
  String uuid;

  @override
  State<IsiDataLoadingTubeMix> createState() => _IsiDataLoadingTubeMixState();
}

class _IsiDataLoadingTubeMixState extends State<IsiDataLoadingTubeMix> {
  GroupButtonController? cb = GroupButtonController(selectedIndex: 0);
  GroupButtonController? cv = GroupButtonController(selectedIndex: 0);
  GroupButtonController? vent = GroupButtonController(selectedIndex: 0);
  GroupButtonController? ht = GroupButtonController(selectedIndex: 0);

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
              if (widget.title == "Production")
                SizedBox(
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
                SizedBox(
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
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Postfill")
                SizedBox(
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
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Postfill")
                SizedBox(
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
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Production")
                SizedBox(
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
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Production")
                SizedBox(
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
                SizedBox(
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
                          controller: cb,
                          options: GroupButtonOptions(
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                          },
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                SizedBox(
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
                          controller: cv,
                          isRadio: true,
                          options: GroupButtonOptions(
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                          },
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                SizedBox(
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
                          controller: vent,
                          isRadio: true,
                          options: GroupButtonOptions(
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                          },
                          buttons: const ['Good', "Not Good"]),
                    ),
                  ),
                ),
              if (widget.title == "Prefill")
                SizedBox(
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
                          controller: ht,
                          isRadio: true,
                          options: GroupButtonOptions(
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                          },
                          buttons: const ['Good', "Not Good"]),
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
              provider.updatePrefillData(context, widget.uuid, 2,
                  cb!.selectedIndex!, vent!.selectedIndex!);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
