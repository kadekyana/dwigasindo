import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentBuatBPTI extends StatefulWidget {
  ComponentBuatBPTI({super.key});

  @override
  State<ComponentBuatBPTI> createState() => _ComponentBuatBPTIState();
}

class _ComponentBuatBPTIState extends State<ComponentBuatBPTI> {
  String? selectCustomer;
  String? selectBptk;

  SingleSelectController<String?> bptk = SingleSelectController<String?>(null);
  SingleSelectController<String?> costumer =
      SingleSelectController<String?>(null);

  bool check = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat BPTI',
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
      body: (provider.isLoadingVer == true)
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
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Jenis BPTI*',
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
                            if (value == "Non BPTK") {
                              setState(() {
                                bptk.clear();
                                selectBptk = null;
                                check = true;
                              });
                            } else {
                              setState(() {
                                costumer.clear();
                                selectCustomer = null;
                                check = false;
                              });
                            }
                          },
                          buttons: ['Non BPTK', "BPTK"]),
                    ),
                  ),
                ),
                (check == false)
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Consumer<ProviderDistribusi>(
                              builder: (context, provider, child) {
                                final bptks = provider.bptk?.data
                                    ?.map((data) =>
                                        {'id': data.id, 'name': data.no})
                                    .toList();
                                // List<String?> bptks = provider.bptk!.data!
                                //     .map((data) => data.id.toString())
                                //     .toList();
                                return CustomDropdown(
                                  controller: bptk,
                                  decoration: CustomDropdownDecoration(
                                      closedBorder: Border.all(
                                          color: Colors.grey.shade400),
                                      expandedBorder: Border.all(
                                          color: Colors.grey.shade400)),
                                  hintText: 'Pilih BPTK',
                                  items: bptks?.map((e) => e['name']).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      final ID = bptks?.firstWhere(
                                        (item) => item['name'] == value,
                                      );
                                      setState(() {
                                        selectBptk = ID!['id'].toString();
                                      });
                                      print("Selected BPTK ID: $selectBptk");
                                    } else {
                                      print("BPTK is null");
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : (check == true)
                        ? Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Consumer<ProviderDistribusi>(
                                  builder: (context, provider, child) {
                                    final tubecustomer = provider
                                        .customer!.data!
                                        .map((data) =>
                                            {'id': data.id, 'name': data.name})
                                        .toList();
                                    return CustomDropdown(
                                      controller: costumer,
                                      decoration: CustomDropdownDecoration(
                                          closedBorder: Border.all(
                                              color: Colors.grey.shade400),
                                          expandedBorder: Border.all(
                                              color: Colors.grey.shade400)),
                                      hintText: 'Pilih Customer',
                                      items: tubecustomer
                                          .map(
                                              (item) => item['name'].toString())
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          final selecttubeC =
                                              tubecustomer.firstWhere((item) =>
                                                  item['name'] == value);
                                          setState(() {
                                            selectCustomer =
                                                selecttubeC['id'].toString();
                                          });
                                          print(
                                              "Selected Customer ID: $selectCustomer");
                                        } else {
                                          print("Customer is null");
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                SizedBox(
                  height: height * 0.01,
                ),
                WidgetButtonCustom(
                    FullWidth: width * 0.93,
                    FullHeight: height * 0.06,
                    title: 'Simpan',
                    onpressed: () async {
                      print("BPTK: ${selectBptk ?? 'Tidak Dipilih'}");
                      print("Customer: ${selectCustomer ?? 'Tidak Dipilih'}");
                      final selectA = (selectBptk != null)
                          ? int.parse(selectBptk.toString())
                          : null;
                      final selectB = (selectCustomer != null)
                          ? int.parse(selectCustomer.toString())
                          : null;
                      await provider.createBPTI(context, selectA, selectB);
                    },
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR)
              ],
            ),
    );
  }
}
