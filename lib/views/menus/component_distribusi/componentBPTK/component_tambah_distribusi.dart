import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponentTambah extends StatelessWidget {
  ComponentTambah({super.key});

  // SingleSelectController<String?> tipe = SingleSelectController<String?>(null);
  SingleSelectController<String?> sumber =
      SingleSelectController<String?>(null);

  TextEditingController no = TextEditingController();

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
      body: (provider.isLoadingC == true)
          ? Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                Container(
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
                Container(
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
                  height: height * 0.05,
                ),
                WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: height * 0.06,
                    title: 'Simpan',
                    onpressed: () {
                      provider.createBPTK(
                        provider.selectedItem,
                        no.text,
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

class ComponentEdit extends StatefulWidget {
  ComponentEdit(
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

      if (selectedCustomer != null) {
        // Set the initial selected value in dropdown (customer's name)
        sumber.value = selectedCustomer.name;
        provider.setSelectedItem(selectedCustomer.id.toString());
      }
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
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                // No Kendaraan input field (editable)
                Container(
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
                Container(
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
