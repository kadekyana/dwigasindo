import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentTambahCradle extends StatefulWidget {
  ComponentTambahCradle({super.key, required this.id});
  int id;

  @override
  State<ComponentTambahCradle> createState() => _ComponentTambahCradleState();
}

class _ComponentTambahCradleState extends State<ComponentTambahCradle> {
  // SingleSelectController<String?> tipe = SingleSelectController<String?>(null);
  SingleSelectController<String?> sumber =
      SingleSelectController<String?>(null);

  int selectPicId = 0;

  List<Map<String, dynamic>> formList = [];
  // List untuk menyimpan data form
  void _addForm() {
    setState(() {
      formList.add({
        "tube_id": null,
      });
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah BPTK',
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: formList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: ListTile(
                      title: Text('Tabung', style: subtitleTextBlack),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Consumer<ProviderDistribusi>(
                          builder: (context, provider, child) {
                            final tube = provider.tube!.data!
                                .map((data) =>
                                    {'id': data.id, 'name': data.code})
                                .toList();

                            return CustomDropdown(
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih Tabung',
                              items: tube.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = tube.firstWhere(
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
                      ),
                    ),
                  ),
                ],
              );
            },
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
                  FullHeight: 40.h,
                  title: 'Tambah Form Tabung',
                  onpressed: _addForm,
                  bgColor: PRIMARY_COLOR,
                  color: PRIMARY_COLOR),
            ),
          ),
          SizedBox(
            width: width,
            height: height * 0.06,
            child: Align(
              alignment: Alignment.topCenter,
              child: WidgetButtonCustom(
                  FullWidth: width * 0.9,
                  FullHeight: 40.h,
                  title: 'Tambah Form Tabung',
                  onpressed: _addForm,
                  bgColor: PRIMARY_COLOR,
                  color: PRIMARY_COLOR),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 50.h,
        margin: EdgeInsets.all(20.w),
        child: WidgetButtonCustom(
            FullWidth: width * 0.9,
            FullHeight: height * 0.06,
            title: 'Simpan',
            onpressed: () {},
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}

class ComponentEdit extends StatefulWidget {
  const ComponentEdit(
      {super.key, this.dataNo, required this.cusId, required this.uuid});

  final String? dataNo;
  final String? uuid;
  final int cusId;

  @override
  _ComponentEditState createState() => _ComponentEditState();
}

class _ComponentEditState extends State<ComponentEdit> {
  TextEditingController no = TextEditingController();
  SingleSelectController<String?> sumber =
      SingleSelectController<String?>(null);

  @override
  void initState() {
    super.initState();

    // If dataNo is provided, set it as the initial value for the controller
    if (widget.dataNo != null && widget.dataNo!.isNotEmpty) {
      no.text = widget.dataNo!;
    }

    // Set the initial value for the dropdown based on cusId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      var selectedCustomer = provider.customer!.data!.firstWhere(
        (customer) => customer.id == widget.cusId,
      );

      // Set the initial selected value in dropdown (customer's name)
      sumber.value = selectedCustomer.name;
      provider.setSelectedItem(selectedCustomer.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Edit BPTK',
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
      body: (provider.isLoadingC == true)
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                // No Kendaraan input field (editable)
                SizedBox(
                  width: width + 0.01,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text('No Kendaraan', style: subtitleTextBlack),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: no,
                        alert: 'No kendaraan harus di isi',
                        hint: 'DK 4532 AU',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ListTile(
                    title: Text('Sumber', style: subtitleTextBlack),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Consumer<ProviderDistribusi>(
                        builder: (context, provider, child) {
                          List<String?> companyNames = provider.customer!.data!
                              .map((data) => data.name)
                              .toList();

                          return CustomDropdown(
                            controller: sumber,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Sumber',
                            items: companyNames,
                            onChanged: (value) {
                              if (value != null) {
                                var selectedCompany =
                                    provider.customer!.data!.firstWhere(
                                  (company) => company.name == value,
                                );
                                provider.setSelectedItem(
                                    selectedCompany.id.toString());
                              } else {
                                print(value);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // Save Button
                WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: height * 0.06,
                    title: 'Simpan',
                    onpressed: () {
                      // Save the data with the ID from selected company
                      provider.editBptk(
                        provider.selectedItem, // the selected ID
                        no.text,
                        widget.uuid!,
                        context,
                      );
                    },
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ],
            ),
    );
  }
}
