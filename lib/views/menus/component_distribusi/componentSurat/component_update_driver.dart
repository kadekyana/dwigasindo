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

import '../../../../providers/provider_surat_jalan.dart';

class ComponentUpdateDriver extends StatefulWidget {
  ComponentUpdateDriver({super.key, required this.uuid});
  String uuid;

  @override
  State<ComponentUpdateDriver> createState() => _ComponentUpdateDriverState();
}

class _ComponentUpdateDriverState extends State<ComponentUpdateDriver> {
  SingleSelectController<String?> driver =
      SingleSelectController<String?>(null);
  TextEditingController noKendaraan = TextEditingController();
  TextEditingController nama = TextEditingController();
  GroupButtonController? type = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSuratJalan>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Surat Jalan',
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
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: const Text(
                    'Type',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: GroupButton(
                        controller: type,
                        isRadio: true,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          // if (value == 'User') {
                          //   nama.clear();
                          // } else {
                          //   driver.clear();
                          // }
                          print('DATA KLIK : $value - $index - $isSelected');
                          // setState(() {
                          //   type = index;
                          // });
                        },
                        buttons: const ['User', "Non User"]),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: const Text(
                    'Driver',
                    style: subtitleTextBlack,
                  ),
                  subtitle: WidgetDropdown(
                    items: const ['Andi Muhammad', 'Dwi', 'Anda'],
                    hintText: 'Tipe',
                    controller: driver,
                    onChanged: (value) {
                      print("Select : $value");
                    },
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: const Text(
                    'Nama',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      alert: 'Nama',
                      hint: 'Nama',
                      controller: nama,
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
                    'Nomor Kendaraan',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      alert: 'L 1234 TR',
                      hint: 'L 1234 TR',
                      controller: noKendaraan,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                width: width,
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: height * 0.05,
                      title: 'Simpan Perubahan',
                      onpressed: () {
                        print(type!.selectedIndex!);
                        if (driver.value != null) {
                          print("DRIVER : ${driver.value} ");
                          provider.updateSuratJalan(
                              context,
                              widget.uuid,
                              type!.selectedIndex!,
                              1,
                              driver.value!,
                              noKendaraan.text,
                              1);
                        } else {
                          print("NAMA : ${nama.text}");
                          provider.updateSuratJalan(
                              context,
                              widget.uuid,
                              type!.selectedIndex!,
                              null,
                              nama.text,
                              noKendaraan.text,
                              1);
                        }

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           ComponentVerifikasiSuratJalan()),
                        // );
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
