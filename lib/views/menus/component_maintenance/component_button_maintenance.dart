import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ComponentButtonMaintenance extends StatefulWidget {
  String title;
  int id;
  ComponentButtonMaintenance({
    super.key,
    required this.title,
    required this.id,
  });
  @override
  State<ComponentButtonMaintenance> createState() =>
      _ComponentButtonMaintenanceState();
}

class _ComponentButtonMaintenanceState
    extends State<ComponentButtonMaintenance> {
  // int selectPicId = 0;
  // int selectPicId1 = 0;
  // int selectPicId2 = 0;
  TextEditingController note = TextEditingController();
  TextEditingController noteK = TextEditingController();
  GroupButtonController? status = GroupButtonController();
  GroupButtonController? g = GroupButtonController();
  GroupButtonController? serviceV = GroupButtonController();
  GroupButtonController? serviceB = GroupButtonController();
  GroupButtonController? gT = GroupButtonController();
  GroupButtonController? gS = GroupButtonController();
  GroupButtonController? pengencangan = GroupButtonController();
  GroupButtonController? gStim = GroupButtonController();
  GroupButtonController? gPen = GroupButtonController();
  GroupButtonController? gTeflon = GroupButtonController();
  GroupButtonController? hY = GroupButtonController();
  GroupButtonController? hE = GroupButtonController();
  bool cek = false;
  bool tlp = false;

  bool? isLead;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Update Status Pengecekan High Preasure',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        sizefont: 14.sp,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Status',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: status,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Not Good",
                        "Claim",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Kondisi Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: note,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kondisi di sini...',
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Valve",
                  style: superTitleTextBlack,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Valve',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: g,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Service Valve Miring',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: serviceV,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Service Bocor Leher Valve',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: serviceB,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Safety Valve",
                  style: superTitleTextBlack,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Teflon',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gT,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Safety Disk',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gS,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Pengencangan',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: pengencangan,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stim",
                  style: superTitleTextBlack,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Stim',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gStim,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pen/Spindle",
                  style: superTitleTextBlack,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Pen/Spindle',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gPen,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'G. Teflon',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gTeflon,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Hydrotest',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: hY,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["Ya", "Tidak"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Heater',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: hE,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["Ya", "Tidak"]),
                ),
              ),
            ),
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
                    controller: noteK,
                    maxLines: null,
                    expands: true,
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
              onpressed: () async {
                print(widget.id);
                await provider.updateHP(
                  context,
                  widget.id,
                  noteK.text,
                  note.text,
                  (status!.selectedIndex! + 1), // Menambahkan 1
                  (g!.selectedIndex! + 1), // Menambahkan 1
                  (serviceV!.selectedIndex! + 1), // Menambahkan 1
                  (serviceB!.selectedIndex! + 1), // Menambahkan 1
                  (gT!.selectedIndex! + 1), // Menambahkan 1
                  (gS!.selectedIndex! + 1), // Menambahkan 1
                  (pengencangan!.selectedIndex! + 1), // Menambahkan 1
                  (gStim!.selectedIndex! + 1), // Menambahkan 1
                  (gPen!.selectedIndex! + 1), // Menambahkan 1
                  (gTeflon!.selectedIndex! + 1), // Menambahkan 1
                  (hY!.selectedIndex! + 1), // Menambahkan 1
                  (hE!.selectedIndex! + 1), // Menambahkan 1
                );

                print('Selected Data:');
                print(
                    'Status: ${status?.selectedIndex != null ? status!.selectedIndex! + 1 : 1}');
                print('Note: ${note.text}');
                print(
                    'G: ${g?.selectedIndex != null ? g!.selectedIndex! + 1 : 1}');
                print(
                    'ServiceV: ${serviceV?.selectedIndex != null ? serviceV!.selectedIndex! + 1 : 1}');
                print(
                    'ServiceB: ${serviceB?.selectedIndex != null ? serviceB!.selectedIndex! + 1 : 1}');
                print(
                    'GT: ${gT?.selectedIndex != null ? gT!.selectedIndex! + 1 : 1}');
                print(
                    'GS: ${gS?.selectedIndex != null ? gS!.selectedIndex! + 1 : 1}');
                print(
                    'Pengencangan: ${pengencangan?.selectedIndex != null ? pengencangan!.selectedIndex! + 1 : 1}');
                print(
                    'GStim: ${gStim?.selectedIndex != null ? gStim!.selectedIndex! + 1 : 1}');
                print(
                    'GPen: ${gPen?.selectedIndex != null ? gPen!.selectedIndex! + 1 : 1}');
                print(
                    'GTeflon: ${gTeflon?.selectedIndex != null ? gTeflon!.selectedIndex! + 1 : 1}');
                print(
                    'HY: ${hY?.selectedIndex != null ? hY!.selectedIndex! + 1 : 1}');
                print(
                    'HE: ${hE?.selectedIndex != null ? hE!.selectedIndex! + 1 : 1}');
                print('Note: ${noteK.text}');
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class FormC2H2 extends StatefulWidget {
  String title;
  FormC2H2({
    super.key,
    required this.title,
  });
  @override
  State<FormC2H2> createState() => _FormC2H2State();
}

class _FormC2H2State extends State<FormC2H2> {
  // int selectPicId = 0;
  // int selectPicId1 = 0;
  // int selectPicId2 = 0;
  TextEditingController serial = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController note = TextEditingController();
  GroupButtonController? tugas = GroupButtonController();
  GroupButtonController? jenis = GroupButtonController();
  bool cek = false;
  bool tlp = false;

  bool? isLead;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Update Status Pengecekan C2H2',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        sizefont: 14.sp,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Status',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: tugas,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Not Good",
                        "Claim",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Valve Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Safety Valve',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Teflon',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pen/Spindle",
                  style: superTitleTextBlack,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Pendek',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Garis',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Standard',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Ring',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Filter',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Saringan',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 70.h,
              child: ListTile(
                title: Text(
                  'Safety Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          if (index == 0) {
                            isLead = true;
                          } else {
                            isLead = false;
                          }
                        });
                      },
                      buttons: const ["✓", "✗"]),
                ),
              ),
            ),
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
                    controller: note,
                    maxLines: null,
                    expands: true,
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
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

class FormAfkir extends StatefulWidget {
  String title;
  FormAfkir({
    super.key,
    required this.title,
  });
  @override
  State<FormAfkir> createState() => _FormAfkirState();
}

class _FormAfkirState extends State<FormAfkir> {
  // int selectPicId = 0;
  // int selectPicId1 = 0;
  // int selectPicId2 = 0;
  int selectPicId = 0;
  TextEditingController note = TextEditingController();
  GroupButtonController? a = GroupButtonController();
  GroupButtonController? b = GroupButtonController();
  GroupButtonController? c = GroupButtonController();
  GroupButtonController? d = GroupButtonController();
  GroupButtonController? e = GroupButtonController();

  bool? isLead;

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  TextEditingController? controller = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Update Status Afkir',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        sizefont: 14.sp,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Hammer Pekak',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: a,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Ya",
                        "Tidak",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Body Tabung Karat',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: b,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Ya",
                        "Tidak",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Bocor Body Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: c,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Ya",
                        "Tidak",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Body Tabung Kembung',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: d,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Ya",
                        "Tidak",
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Ada Sambungan Pengelasan',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: e,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const [
                        "Ya",
                        "Tidak",
                      ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Pilih Penerima',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Consumer<ProviderSales>(
                    builder: (context, provider, child) {
                      final pic = provider.modelUsersPic!.data!
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Penerima',
                        items: pic.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            selectPicId = int.parse(selected['id'].toString());
                          });

                          print("Selected ID: $selectPicId");
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap:
                      _showImageSourceDialog, // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fitHeight,
                              )
                            : Padding(
                                padding: EdgeInsets.all(10.h),
                                child: SvgPicture.asset(
                                    'assets/images/gambar.svg'),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
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
                    controller: note,
                    maxLines: null,
                    expands: true,
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
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

class UpdateStatusToUsers extends StatefulWidget {
  String title;
  int id;
  int lastStatus;
  UpdateStatusToUsers(
      {super.key,
      required this.title,
      required this.id,
      required this.lastStatus});
  @override
  State<UpdateStatusToUsers> createState() => _UpdateStatusToUsersState();
}

class _UpdateStatusToUsersState extends State<UpdateStatusToUsers> {
  // int selectPicId = 0;
  // int selectPicId1 = 0;
  int selectPicId = 0;
  TextEditingController note = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  TextEditingController? controller = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Update Status ${widget.title}',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Pilih Penerima',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Consumer<ProviderSales>(
                    builder: (context, provider, child) {
                      final pic = provider.modelUsersPic!.data!
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Penerima',
                        items: pic.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            selectPicId = int.parse(selected['id'].toString());
                          });

                          print("Selected ID: $selectPicId");
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: note,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan catatan di sini...',
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
              width: width,
              height: 80.h,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap:
                      _showImageSourceDialog, // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fitHeight,
                              )
                            : Padding(
                                padding: EdgeInsets.all(10.h),
                                child: SvgPicture.asset(
                                    'assets/images/gambar.svg'),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
              onpressed: () async {
                print(widget.id);
                print(widget.lastStatus);
                await provider.updateKonfirmasi(context, widget.id, note.text,
                    selectPicId, widget.lastStatus, _imageFile!.path);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
