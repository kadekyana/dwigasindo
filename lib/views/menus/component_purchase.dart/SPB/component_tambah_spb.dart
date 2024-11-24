import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentTambahSpb extends StatefulWidget {
  const ComponentTambahSpb({super.key});
  @override
  State<ComponentTambahSpb> createState() => _ComponentTambahSpbState();
}

class _ComponentTambahSpbState extends State<ComponentTambahSpb> {
  // Timer? _timer;
  TextEditingController tahun = TextEditingController();
  TextEditingController serial = TextEditingController();
  TextEditingController lokasi = TextEditingController();

  SingleSelectController<String?> jenisTabung =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> customer =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> jenisGas =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> supllier =
      SingleSelectController<String?>(null);

  String selectTubeGas = '';
  int? selectCustomer;
  int? selectSupllier;

  int? owner = 0;
  int? nonSingletubeType;
  int? selectnonGrade;
  bool nonGrade = true;
  int? selectedGradeIndex;

  bool isSingle = false;

  List<String>? tubeGrade;
  List<String>? tubeType;
  List<Map<String, dynamic>>? tubeGas;
  List<Map<String, dynamic>>? tubecustomer;
  List<Map<String, dynamic>>? tubesupplier;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        serial.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final provider = Provider.of<ProviderDistribusi>(context, listen: false);

  //   // Ambil data dan cek apakah tidak null
  //   tubeGrade = provider.tubeGrades?.data.map((data) => data.name).toList();
  //   tubeType = provider.tubeTypes?.data.map((data) => data.name).toList();

  //   tubeGas = provider.tubeGas?.data
  //       .map((data) => {'id': data.id, 'name': data.name})
  //       .toList();

  //   tubecustomer = provider.customer?.data
  //       .map((data) => {'id': data.id, 'name': data.name})
  //       .toList();

  //   tubesupplier = provider.supllier?.data
  //       ?.map((data) => {'id': data.id, 'name': data.name})
  //       .toList();

  //   // Cek data supplier dan customer
  //   print("Supllier data: ${provider.supllier?.data}");
  //   print("Customer data: ${provider.customer?.data}");
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Tambah Tabung',
        back: true,
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Tanggal',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: serial,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Jenis SPB',
                    style: subtitleTextBlack,
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
                        buttons: ['Barang', "Jasa"]),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          'Item Barang',
                          style: subtitleTextBlack,
                        ),
                        subtitle: WidgetDropdown(
                          items: ['a', 'b'],
                          hintText: 'Item Barang',
                          controller: jenisGas,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Qty',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: tahun,
                            alert: 'Qty',
                            hint: 'Qty',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: WidgetForm(
                  controller: tahun,
                  alert: 'Isi Spesifikasi',
                  hint: 'Isi Spesifikasi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: width,
                  height: height * 0.25,
                  child: ListTile(
                    title: Text(
                      'PIC Approval',
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Verifikasi',
                            items: ['a'],
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
                            items: ['a'],
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Menyetujui',
                            items: ['a'],
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
              onpressed: () async {},
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
