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

class ComponentTambahPo extends StatefulWidget {
  ComponentTambahPo({super.key});
  @override
  State<ComponentTambahPo> createState() => _ComponentTambahPoState();
}

class _ComponentTambahPoState extends State<ComponentTambahPo> {
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
                  'SPB',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: tahun,
                    alert: 'Nama SPB',
                    hint: 'Nama SPB',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
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
              child: ListTile(
                title: Text(
                  'Kategori',
                  style: subtitleTextBlack,
                ),
                subtitle: WidgetDropdown(
                  items: ['PCS'],
                  hintText: 'Kategori',
                  controller: jenisGas,
                  onChanged: (value) {},
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
                  'Supllier',
                  style: subtitleTextBlack,
                ),
                subtitle: WidgetDropdown(
                  items: ['a', 'b'],
                  hintText: 'Supplier',
                  controller: jenisGas,
                  onChanged: (value) {},
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
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              width: width,
              height: height * 0.1,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Harga',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'Harga',
                          hint: 'Harga',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'QTY',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'QTY',
                          hint: 'QTY',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Total Pembayaran',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'Total Pembayaran',
                          hint: 'Total Pembayaran',
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
              height: height * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: WidgetForm(
                controller: tahun,
                alert: '2024',
                hint: '2024',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Container(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Syarat Pembayaran',
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
                      buttons: ['Tunai', "Bertahap"]),
                ),
              ),
            ),
            Container(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Deadline Pembayaran',
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
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Total Harga',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'Total Harga',
                          hint: 'Total Harga',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'PPN',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'PPN',
                          hint: 'PPN',
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
              height: height * 0.02,
            ),
            Container(
              width: width,
              height: height * 0.1,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Bertahap',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'Bertahap',
                          hint: 'Bertahap',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        '%',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: '%',
                          hint: '%',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Total',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: tahun,
                          alert: 'Total',
                          hint: 'Total',
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
              height: height * 0.02,
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
            SizedBox(
              height: height * 0.05,
            ),
          ],
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
