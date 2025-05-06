import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ComponentMenuBuatTugas extends StatefulWidget {
  const ComponentMenuBuatTugas({
    super.key,
  });
  @override
  State<ComponentMenuBuatTugas> createState() => _ComponentMenuBuatTugasState();
}

class _ComponentMenuBuatTugasState extends State<ComponentMenuBuatTugas> {
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int? customer;
  int? lead;
  int? lokasi;
  TextEditingController serial = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController note = TextEditingController();
  GroupButtonController? tugas = GroupButtonController();
  GroupButtonController? jenis = GroupButtonController();
  bool cek = false;
  bool tlp = false;

  bool? isLead;

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
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "nama": null,
        "bagian": null,
        "nomor": null,
        "email": null,
      });
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

  void _addFormB() {
    setState(() {
      formListB.add({"bertahap": null, "%": null, 'total': null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB() {
    if (formListB.isNotEmpty) {
      setState(() {
        formListB.removeLast();
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDateTime =
            DateFormat('dd-MM-yyyy HH:mm').format(combinedDateTime);
        setState(() {
          serial.text = formattedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat Tugas Kunjungan',
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
            SizedBox(
              width: width,
              height: 150.h,
              child: ListTile(
                title: Text(
                  'Pilih Tugas',
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
                        "Prospek",
                        "Existing",
                        "Komplain",
                        "Claim"
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Jenis Customer',
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
                      buttons: const ["Lead", "Customer"]),
                ),
              ),
            ),
            if (isLead == true)
              Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(
                    'Pilih Lead',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderSales>(
                      builder: (context, provider, child) {
                        final pic = provider.leads!.data
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();
                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Lead',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              lead = int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $lead");
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (isLead == false)
              Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(
                    'Pilih Customer',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderDistribusi>(
                      builder: (context, provider, child) {
                        final pic = provider.customer!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();
                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Customer',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              customer = int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $customer");
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                title: Text(
                  'Lokasi',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: Consumer<ProviderSales>(
                    builder: (context, provider, child) {
                      final grade = provider.district?.data
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomAutocomplete(
                        data: grade?.map((e) => e['name']).toList() ?? [],
                        displayString: (item) => item.toString(),
                        onSelected: (item) {
                          print("Selected Item: $item");

                          final selected = grade?.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            lokasi = int.parse(selected!['id'].toString());
                          });

                          print("Selected ID: $lokasi");
                        },
                        labelText: 'Cari Barang',
                        controller: kecamatan,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 130.h,
              child: ListTile(
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 80.h,
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
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width,
                height: 250.h,
                child: ListTile(
                  title: Text(
                    'PIC Approval',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Column(
                    children: [
                      Consumer<ProviderSales>(
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
                            hintText: 'Pilih PIC Verifikasi',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId");
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Consumer<ProviderSales>(
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
                            hintText: 'Pilih PIC Menyetujui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId1 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId1");
                            },
                          );
                        },
                      ),
                    ],
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
                print("Data yang dikirim:");
                print("Index Tugas: ${tugas!.selectedIndex! + 1}");
                print("Index Jenis: ${jenis!.selectedIndex! + 1}");
                print("Customer ID: ${customer ?? 0}");
                print("Lead ID: ${lead ?? 0}");
                print("Kecamatan: ${kecamatan.text}");
                print("Note: ${note.text}");
                print("PIC ID 1: $selectPicId");
                print("PIC ID 2: $selectPicId1");

                if (isLead == true) {
                  provider.createTugasKunjungan(
                    context,
                    (tugas!.selectedIndex! + 1),
                    (jenis!.selectedIndex! + 1),
                    null,
                    (lead ?? 0),
                    kecamatan.text,
                    note.text,
                    selectPicId,
                    selectPicId1,
                  );
                } else {
                  provider.createTugasKunjungan(
                    context,
                    (tugas!.selectedIndex! + 1),
                    (jenis!.selectedIndex! + 1),
                    (customer ?? 0),
                    null,
                    kecamatan.text,
                    note.text,
                    selectPicId,
                    selectPicId1,
                  );
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
