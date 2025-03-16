import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelDetailLead.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/widget_note.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline_list.dart';

class ComponentDataCrm extends StatefulWidget {
  ComponentDataCrm({super.key, required this.title});
  String title;
  @override
  _ComponentDataCrmState createState() => _ComponentDataCrmState();
}

class _ComponentDataCrmState extends State<ComponentDataCrm> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Leads'},
    {'title': 'Lead Trash'},
  ];

  // Data untuk grafik spline
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        center: true,
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index]; // Akses data dari list
            return GestureDetector(
              onTap: () async {
                if (!mounted) return;

                // Tampilkan Dialog Loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                try {
                  await Future.wait([
                    Provider.of<ProviderItem>(context, listen: false)
                        .getAllItem(context),
                    Provider.of<ProviderItem>(context, listen: false)
                        .getAllUnit(context),
                    Provider.of<ProviderOrder>(context, listen: false)
                        .getMasterProduk(context),
                    provider.getLeads(context, 0),
                    provider.getSummaryLeads(context),
                    provider.getLeadsTrash(context, 1),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  (item['title'] == "Leads")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentLeads(
                              title: item['title'],
                            ),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentLeadsTrash(
                              title: item['title'],
                            ),
                          ),
                        );
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                height: height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                        color: Colors.grey.shade300),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/distribusi.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(item['title'], // Gunakan title dari list
                            style: titleTextBlack),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ComponentLeads extends StatefulWidget {
  ComponentLeads({super.key, required this.title});
  String title;
  @override
  _ComponentLeadsState createState() => _ComponentLeadsState();
}

class _ComponentLeadsState extends State<ComponentLeads> {
  bool _showForm = false;
  int? _selectedCardIndex;

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.leads?.data;
    final dataSummary = provider.summaryLeads?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        center: true,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                      "assets/images/customer.png")),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Lead\n",
                                        style: minisubtitleTextBlack),
                                    TextSpan(
                                        text: dataSummary!.totalLead.toString(),
                                        style: subtitleTextBoldBlack),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                      "assets/images/customer.png")),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Customer\n",
                                        style: minisubtitleTextBlack),
                                    TextSpan(
                                        text: dataSummary.totalDeal.toString(),
                                        style: subtitleTextBoldBlack),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.maxFinite,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Search bar
                  WidgetButtonCustom(
                      FullWidth: width * 0.42,
                      FullHeight: 43.h,
                      title: "Tambah Leads",
                      onpressed: () async {
                        provider.getDistrict(context, '');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentTambahLead(
                              title: 'Tambah Lead',
                            ),
                          ),
                        );
                      },
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  // filter bar
                  Container(
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 160.h,
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xffE4E4E4),
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: 40.h,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 120.w,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(
                                          dataCard.type == 1
                                              ? "Low Potential"
                                              : dataCard.type == 2
                                                  ? "Med Potential"
                                                  : "High Potential",
                                          style: titleText),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 150.w,
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Pada : ${provider.formatDate(dataCard.createdAt.toString())} | ${provider.formatTime(dataCard.createdAt.toString())}",
                                          style: minisubtitleTextGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _buildInfoRow(
                                        Icons.location_city,
                                        dataCard.name,
                                        Icons.pin_drop_rounded,
                                        dataCard.districtComplete),
                                    _buildInfoRow(
                                        Icons.person_rounded,
                                        dataCard.pic,
                                        Icons.person_2_rounded,
                                        dataCard.salesName),
                                    _buildInfoRow(
                                        Icons.wechat_rounded,
                                        dataCard.phone,
                                        Icons.replay,
                                        (dataCard.lastStatus == 1)
                                            ? "Add Target"
                                            : (dataCard.lastStatus == 2)
                                                ? "Product Knoledge"
                                                : (dataCard.lastStatus == 3)
                                                    ? "Send Quotation"
                                                    : (dataCard.lastStatus == 4
                                                        ? "Reminder Response"
                                                        : (dataCard.lastStatus ==
                                                                5)
                                                            ? "Negotiation"
                                                            : "Visiting")),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              margin: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: WidgetButtonCustom(
                                      FullWidth: 100,
                                      FullHeight: 30.h,
                                      title: "Update Status",
                                      onpressed: () {
                                        setState(() {
                                          if (_selectedCardIndex == index) {
                                            _showForm =
                                                !_showForm; // Toggle form
                                          } else {
                                            _selectedCardIndex = index;
                                            _showForm = true;
                                          }
                                        });
                                      },
                                      bgColor: PRIMARY_COLOR,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: WidgetButtonCustom(
                                      FullWidth: 100,
                                      FullHeight: 30.h,
                                      title: "Follow Up",
                                      onpressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ComponentTambahFollowUp(
                                              id: dataCard.id,
                                            ),
                                          ),
                                        );
                                      },
                                      bgColor: PRIMARY_COLOR,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: WidgetButtonCustom(
                                      FullWidth: 100,
                                      FullHeight: 30.h,
                                      title: "Lihat Data",
                                      onpressed: () async {
                                        if (!mounted) return;

                                        // Tampilkan Dialog Loading
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        try {
                                          await Future.wait([
                                            provider.getDetailLead(
                                                context, dataCard.id),
                                            provider.getDocumentationLeads(
                                                context, dataCard.id),
                                          ]);

                                          // Navigate sesuai kondisi
                                          Navigator.of(context)
                                              .pop(); // Tutup Dialog Loading
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ComponentFollowUp(
                                                title: 'Detail Lead',
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          Navigator.of(context)
                                              .pop(); // Tutup Dialog Loading
                                          print('Error: $e');
                                          // Tambahkan pesan error jika perlu
                                        }
                                      },
                                      bgColor: PRIMARY_COLOR,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tampilkan _buildWeightForm jika item ini yang diklik
                      if (_showForm && _selectedCardIndex == index)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              _buildWeightForm("ID-${index + 1}", dataCard.id),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon1, String text1, IconData icon2, String text2) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon1, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text1,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon2, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text2,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightForm(String idStr, int id) {
    SingleSelectController<String?>? form =
        SingleSelectController<String?>(null);
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Update Status",
            style: subtitleTextBoldBlack,
          ),
        ),
        SizedBox(height: 10.h),
        CustomDropdown(
          controller: form,
          decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: Colors.grey.shade400),
              expandedBorder: Border.all(color: Colors.grey.shade400)),
          hintText: 'Pilih Status',
          items: const ['Low Potential', 'Med Potential', 'High Potential'],
          onChanged: (value) {},
        ),
        SizedBox(height: 10.h),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width,
          FullHeight: 35.h,
          title: 'Submit',
          onpressed: () async {
            final provider = Provider.of<ProviderSales>(context, listen: false);
            print(form.value);
            await provider.updateStatusLead(
                context,
                id,
                (form.value == "Low Potential")
                    ? 1
                    : (form.value == "Med Potential")
                        ? 2
                        : 3);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}

class ComponentTambahLead extends StatefulWidget {
  ComponentTambahLead({super.key, required this.title});
  String title;
  @override
  State<ComponentTambahLead> createState() => _ComponentTambahLeadState();
}

class _ComponentTambahLeadState extends State<ComponentTambahLead> {
  TextEditingController serial = TextEditingController();
  bool cek = false;
  bool tlp = false;
  int? selectGradeId;
  bool selectGrade = false;
  GroupButtonController? jenis = GroupButtonController(selectedIndex: 0);
  GroupButtonController? coorporation = GroupButtonController(selectedIndex: 0);
  TextEditingController nama = TextEditingController();
  TextEditingController kode = TextEditingController();
  GroupButtonController? gradeA = GroupButtonController(selectedIndex: 0);
  GroupButtonController? gradeC = GroupButtonController(selectedIndex: 0);
  TextEditingController hpp = TextEditingController();
  TextEditingController district = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Nama PT',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: nama,
                    alert: 'Nama PT',
                    hint: 'Nama PT',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'PIC',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: kode,
                    change: (value) {},
                    alert: 'PIC',
                    hint: 'PIC',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'No Handphone',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: hpp,
                    change: (value) {},
                    alert: 'No Handphone',
                    hint: 'No Handphone',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 120.h,
              child: ListTile(
                title: Text(
                  'Jenis Produk',
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
                      },
                      buttons: const [
                        'Low Potential',
                        "Med Potential",
                        "High Potential"
                      ]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Pilih District',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
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
                            selectGradeId =
                                int.parse(selected!['id'].toString());
                          });

                          print("Selected ID: $selectGradeId");
                        },
                        labelText: 'Cari Barang',
                        controller: district,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 120.h,
              child: ListTile(
                title: Text(
                  'Jenis Produk',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: coorporation,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['Perusahaan', "Perorangan"]),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
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
                if (!mounted) return;

                // Tampilkan Dialog Loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                try {
                  await Future.wait([
                    provider.createLead(
                      context,
                      nama.text,
                      kode.text,
                      hpp.text,
                      selectGradeId!,
                      (jenis!.selectedIndex! + 1),
                      (coorporation!.selectedIndex! + 1),
                    ),
                  ]);
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class ComponentLeadsTrash extends StatefulWidget {
  ComponentLeadsTrash({super.key, required this.title});
  String title;
  @override
  _ComponentLeadsTrashState createState() => _ComponentLeadsTrashState();
}

class _ComponentLeadsTrashState extends State<ComponentLeadsTrash> {
  bool _showForm = false;
  int? _selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.leadsTrash!.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        center: true,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset("assets/images/customer.png")),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Trash\n", style: minisubtitleTextBlack),
                          TextSpan(text: "100", style: subtitleTextBoldBlack),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return Column(
                    children: [
                      Stack(
                        children: [
                          // Card utama
                          Container(
                            width: double.maxFinite,
                            height: 160.h,
                            margin: EdgeInsets.only(bottom: height * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Color(0xffE4E4E4),
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 40.h,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 120.w,
                                          height: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Text(
                                              dataCard.type == 1
                                                  ? "Low Potential"
                                                  : dataCard.type == 2
                                                      ? "Med Potential"
                                                      : "High Potential",
                                              style: titleText),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          width: 150.w,
                                          height: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "Pada : ${provider.formatDate(dataCard.createdAt.toString())} | ${provider.formatTime(dataCard.createdAt.toString())}",
                                              style: minisubtitleTextGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        _buildInfoRow(
                                            Icons.location_city,
                                            dataCard.name,
                                            Icons.pin_drop_rounded,
                                            dataCard.districtComplete),
                                        _buildInfoRow(
                                            Icons.person_rounded,
                                            dataCard.pic,
                                            Icons.person_2_rounded,
                                            dataCard.salesName),
                                        _buildInfoRow(
                                            Icons.wechat_rounded,
                                            dataCard.phone,
                                            Icons.replay,
                                            (dataCard.lastStatus == 1)
                                                ? "Add Target"
                                                : (dataCard.lastStatus == 2)
                                                    ? "Product Knoledge"
                                                    : (dataCard.lastStatus == 3)
                                                        ? "Send Quotation"
                                                        : (dataCard.lastStatus ==
                                                                4
                                                            ? "Reminder Response"
                                                            : (dataCard.lastStatus ==
                                                                    5)
                                                                ? "Negotiation"
                                                                : "Visiting")),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width,
                                  height: 40.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: WidgetButtonCustom(
                                          FullWidth: 100,
                                          FullHeight: 30.h,
                                          title: "Back To Lead",
                                          onpressed: () async {
                                            await provider.updateLead(
                                                context, dataCard.id);
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentLeads(
                                                        title: 'Leads'),
                                              ),
                                            );
                                          },
                                          bgColor: PRIMARY_COLOR,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: WidgetButtonCustom(
                                          FullWidth: 100,
                                          FullHeight: 30.h,
                                          title: "Lihat Data",
                                          onpressed: () async {
                                            if (!mounted) return;

                                            // Tampilkan Dialog Loading
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            );

                                            try {
                                              await Future.wait([
                                                provider.getDetailLead(
                                                    context, dataCard.id),
                                                provider.getDocumentationLeads(
                                                    context, dataCard.id),
                                              ]);

                                              // Navigate sesuai kondisi
                                              Navigator.of(context)
                                                  .pop(); // Tutup Dialog Loading
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComponentFollowUp(
                                                    title: "Detail Lead Trash",
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              Navigator.of(context)
                                                  .pop(); // Tutup Dialog Loading
                                              print('Error: $e');
                                              // Tambahkan pesan error jika perlu
                                            }
                                          },
                                          bgColor: PRIMARY_COLOR,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Watermark "TRASH" dengan rotasi 45 derajat
                          Positioned(
                            top: 50.h,
                            left: 100.w,
                            child: Align(
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle:
                                    -25 * 3.1415927 / 180, // Rotasi 45 derajat
                                child: const Opacity(
                                  opacity: 0.2, // Transparansi watermark
                                  child: Text(
                                    "TRASH",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Tampilkan _buildWeightForm jika item ini yang diklik
                      if (_showForm && _selectedCardIndex == index)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _buildWeightForm("ID-${index + 1}"),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon1, String text1, IconData icon2, String text2) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon1, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text1,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon2, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text2,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightForm(String idStr) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Update Status",
            style: subtitleTextBoldBlack,
          ),
        ),
        SizedBox(height: 10.h),
        CustomDropdown(
          decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: Colors.grey.shade400),
              expandedBorder: Border.all(color: Colors.grey.shade400)),
          hintText: 'Pilih Status',
          items: const ['Low Potential', 'High Potential'],
          onChanged: (value) {},
        ),
        SizedBox(height: 10.h),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width,
          FullHeight: 35.h,
          title: 'Submit',
          onpressed: () {
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}

class ComponentFollowUp extends StatefulWidget {
  ComponentFollowUp({super.key, required this.title});
  String title;
  @override
  State<ComponentFollowUp> createState() => _ComponentFollowUpState();
}

class _ComponentFollowUpState extends State<ComponentFollowUp> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  bool isExpanded = false;

  final List<File> images = []; // List untuk menyimpan gambar

  /// Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source, int id) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      setState(() {
        images.add(imageFile); // Simpan gambar ke dalam list sementara
      });

      // Upload gambar ke server

      final provider = Provider.of<ProviderSales>(context, listen: false);
      final filePath = await provider.uploadFile(
          context, imageFile, imageFile.path.split("/").last);
      await provider.uploadDoc(context, id, filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.detailLead!.data;
    final dataDoc = provider.documentationLead!.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Detail Lead",
        colorBG: Colors.grey.shade100,
        center: true,
        back: true,
        colorBack: Colors.black,
        route: () {
          Navigator.pop(context);
        },
        colorTitle: Colors.black,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: 5.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: width,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50.w,
                            height: 50.h,
                            child: Image.asset('assets/images/customer.png'),
                          ),
                          Container(
                            width: 100.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.w),
                                topLeft: Radius.circular(15.w),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                data!.type == 1
                                    ? "Low Potential"
                                    : data.type == 2
                                        ? "Med Potential"
                                        : "High Potential",
                                style: subtitleTextBold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 20,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                data.typeCoorporation == 1
                                    ? "Perusahaan"
                                    : data.typeCoorporation == 2
                                        ? "Perorangan"
                                        : "-",
                                style: subtitleTextNormalblack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildInfoRow(Icons.location_city, data.name!,
                        Icons.pin_drop_rounded, data.districtComplete!),
                    _buildInfoRow(Icons.person_rounded, data.pic!,
                        Icons.person_2_rounded, data.username!),
                    _buildInfoRow(
                      Icons.wechat_rounded,
                      data.phone!,
                      Icons.replay,
                      (data.lastStatus == 1)
                          ? "Add Target"
                          : (data.lastStatus == 2)
                              ? "Product Knoledge"
                              : (data.lastStatus == 3)
                                  ? "Send Quotation"
                                  : (data.lastStatus == 4
                                      ? "Reminder Response"
                                      : (data.lastStatus == 5)
                                          ? "Negotiation"
                                          : "Visiting"),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 40.h,
                      width: width,
                      child: GroupButton(
                          isRadio: true,
                          controller: _groupButtonController,
                          options: GroupButtonOptions(
                            buttonHeight: 30.h,
                            buttonWidth: 100.w,
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                            if (index == 0) {
                              setState(() {
                                selectButton = true;
                              });
                            } else {
                              setState(() {
                                selectButton = false;
                              });
                            }
                          },
                          buttons: const ['Follow Up', "Dokumentasi"]),
                    ),
                  ],
                ),
              ),
            ),
            if (selectButton == true)
              SizedBox(
                width: width,
                height: height * 0.55,
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Timeline.builder(
                          markerBuilder: (context, index) => _buildTimelineItem(
                            data.details![index],
                            provider.formatDate(data.createdAt.toString()),
                            provider.formatTime(data.createdAt.toString()),
                          ),
                          context: context,
                          markerCount: isExpanded ? 1 : data.details!.length,
                          properties: TimelineProperties(
                            markerGap: 0.h,
                            iconSize: 12.w,
                            timelinePosition: TimelinePosition.start,
                          ),
                        ),
                      ),
                    ),
                    // Tombol Expand/Collapse tetap terlihat
                    if (widget.title == "Detail Lead")
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color:
                                  PRIMARY_COLOR, // Tambahkan background agar tidak tertutup konten
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width,
                                  FullHeight: 40.h,
                                  title: 'Pindah Ke Trash',
                                  onpressed: () async {
                                    await provider.updateLead(
                                        context, data.id!);
                                  },
                                  color: SECONDARY_COLOR,
                                  bgColor: SECONDARY_COLOR,
                                ),
                              ),
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width,
                                  FullHeight: 40.h,
                                  title: 'Closing Deal',
                                  onpressed: () async {
                                    await provider.closingDeal(
                                        context, data.id!);
                                  },
                                  color: PRIMARY_COLOR,
                                  bgColor: PRIMARY_COLOR,
                                ),
                              ),
                            ],
                          )),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            if (selectButton == false)
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    width: width,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.grey.shade400,
                          blurRadius: 1,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1D2340),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Dokumentasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // GridView untuk menampilkan gambar
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataDoc!.length +
                                images.length +
                                1, // Menambahkan 1 item untuk tombol upload
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 kolom per baris
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:
                                  1, // Kotak gambar tetap proporsional
                            ),
                            itemBuilder: (context, index) {
                              if (index < dataDoc.length) {
                                // Menampilkan gambar dari API (dataDoc)
                                return _buildImageNetwork(dataDoc[index].path!);
                              } else if (index == dataDoc.length) {
                                // Menampilkan tombol upload di slot terakhir
                                return _buildUploadButton(data.id!);
                              }
                            },
                          ),
                        ),

                        if (provider.uploadProgress > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              children: [
                                LinearProgressIndicator(
                                  value: provider.uploadProgress / 100,
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 10),
                                Text((provider.uploadProgress < 100)
                                    ? "${provider.uploadProgress.toStringAsFixed(2)}% Uploading..."
                                    : "Berhasil Upload"),
                              ],
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
    );
  }

  /// Widget untuk menampilkan gambar dari URL (data API)
  Widget _buildImageNetwork(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  /// Widget untuk menampilkan gambar yang di-upload
  Widget _buildImageFile(File imageFile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.file(
            imageFile,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                setState(() {
                  images.remove(imageFile); // Hapus gambar dari list
                });
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget tombol upload gambar
  Widget _buildUploadButton(int id) {
    return GestureDetector(
      onTap: () => _showImagePickerDialog(id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: const Center(
          child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
        ),
      ),
    );
  }

  /// Menampilkan dialog untuk memilih sumber gambar (kamera atau galeri)
  void _showImagePickerDialog(int id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery, id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera, id);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(
      IconData icon1, String text1, IconData icon2, String text2) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon1, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text1,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon2, size: 20),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(text2,
                      style: subtitleTextNormalblack,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildTimelineItem(Detail item, String tanggal, String jam) {
    return Marker(
      child: Container(
        width: 300.w,
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h, top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: PRIMARY_COLOR),
              child: Center(
                  child: Text(
                      (item.status == 1)
                          ? "Add Target"
                          : (item.status == 2)
                              ? "Product Knoledge"
                              : (item.status == 3)
                                  ? "Send Quotation"
                                  : (item.status == 4
                                      ? "Reminder Response"
                                      : (item.status == 5)
                                          ? "Negotiation"
                                          : "Visiting"),
                      style: subtitleTextBold)),
            ),
            SizedBox(height: 4.h),
            Text(
              jam,
              style: subtitleTextNormalGrey,
            ),
            SizedBox(height: 4.h),
            Text(
              item.note!,
              textAlign: TextAlign.justify,
              style: subtitleTextNormalblack,
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentTambahFollowUp extends StatefulWidget {
  ComponentTambahFollowUp({super.key, required this.id});
  int id;
  @override
  State<ComponentTambahFollowUp> createState() =>
      _ComponentTambahFollowUpState();
}

class _ComponentTambahFollowUpState extends State<ComponentTambahFollowUp> {
  TextEditingController serial = TextEditingController();
  SingleSelectController<String?> follow =
      SingleSelectController<String?>(null);
  GroupButtonController? button = GroupButtonController(selectedIndex: 0);
  int selectProdukId = 0;
  int selectUnitId = 0;
  int selectItemId = 0;
  TextEditingController? produkC = TextEditingController();
  quill.QuillController? controller;

  @override
  void initState() {
    super.initState();
    controller = quill.QuillController.basic(); // Inisialisasi controller
  }

  bool cek = false;
  int jenis = 0;
  bool tlp = false;

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
        "jenis": null,
        "pilih": null, // Pastikan ini kosong saat form baru ditambahkan
        "gas": null,
        "cylinder": null,
        "filling": null,
        "filling1": null,
        "unit": null,
        "harga": null,
        "controller":
            TextEditingController(), // Pastikan setiap form punya controller sendiri
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
      formListB.add({"item": null, 'harga': null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    if (formListB.isNotEmpty) {
      setState(() {
        formListB.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Data Follow Up',
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
              child: ListTile(
                title: Text(
                  'Pilih Follow Up',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: CustomDropdown(
                    controller: follow,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
                        expandedBorder:
                            Border.all(color: Colors.grey.shade400)),
                    hintText: 'Pilih Follow Up',
                    items: const [
                      'Product Knowledge',
                      'Send Quotation',
                      'Reminder Response',
                      'Negotiation',
                      'Visiting'
                    ],
                    onChanged: (value) {
                      print(follow.value);
                      setState(() {
                        follow.value =
                            value; // Update nilai dropdown dengan setState
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 250.h,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 16.w, right: 20.w),
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: NoteForm(controller: controller!)),
              ),
            ),
            // Gas
            if (follow.value == "Send Quotation") ...[
              (formList.isEmpty)
                  ? Container(
                      width: width,
                      margin:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        'Form Produk Kosong',
                        style: superTitleTextBlack,
                      )),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: formList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                height: 25.h,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  'List Produk ${index + 1}',
                                  style: superTitleTextBlack,
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: width,
                                height: 80.h,
                                child: ListTile(
                                  title: Text(
                                    'Jenis Produk',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.topLeft,
                                    child: GroupButton(
                                        isRadio: true,
                                        controller: button,
                                        options: GroupButtonOptions(
                                          selectedColor: PRIMARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        onSelected: (value, index, isSelected) {
                                          print(
                                              'DATA KLIK : $value - $index - $isSelected');
                                          if (index == 0) {
                                            setState(() {
                                              jenis = 0;
                                            });
                                          } else if (index == 1) {
                                            setState(() {
                                              jenis = 1;
                                            });
                                          } else {
                                            setState(() {
                                              jenis = 2;
                                            });
                                          }
                                          setState(() {
                                            formList[index]['jenis'] =
                                                index + 1;
                                          });
                                        },
                                        buttons: const ['Gas', 'Jasa']),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 80.h,
                                child: ListTile(
                                  title: Text(
                                    'Pilih Produk',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.topLeft,
                                    child: Consumer<ProviderOrder>(
                                      builder: (context, provider, child) {
                                        final produk = provider.produk!.data!
                                            .map((data) => {
                                                  'id': data.id,
                                                  'name': data.name
                                                })
                                            .toList();

                                        return CustomAutocomplete(
                                          data: produk
                                                  .map((e) => e['name'])
                                                  .toList() ??
                                              [],
                                          displayString: (item) =>
                                              item.toString(),
                                          onSelected: (item) {
                                            print("Selected Item: $item");

                                            final selected = produk.firstWhere(
                                              (e) => e['name'] == item,
                                            );

                                            setState(() {
                                              selectProdukId = int.parse(
                                                  selected!['id'].toString());
                                            });

                                            setState(() {
                                              formList[index]['pilih'] =
                                                  selectProdukId;
                                            });

                                            print(
                                                "Selected ID: $selectProdukId");
                                          },
                                          labelText: 'Cari Barang',
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 100.h,
                                child: ListTile(
                                  title: Text(
                                    'Gas Purity',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    child: WidgetForm(
                                      change: (value) {
                                        setState(() {
                                          formList[index]['gas'] = value;
                                        });
                                      },
                                      alert: 'Gas Purity',
                                      hint: 'Gas Purity',
                                      typeInput: TextInputType.text,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 100.h,
                                child: ListTile(
                                  title: Text(
                                    'Cylinder Volume',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    child: WidgetForm(
                                      change: (value) {
                                        setState(() {
                                          formList[index]['cylinder'] = value;
                                        });
                                      },
                                      alert: 'Cylinder Volume',
                                      hint: 'Cylinder Volume',
                                      typeInput: TextInputType.number,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 100.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 210.w,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 16.w, right: 5.w),
                                        title: Text(
                                          'Filling Pressure',
                                          style: subtitleTextBlack,
                                        ),
                                        subtitle: Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: WidgetForm(
                                            alert: 'Contoh : 12',
                                            hint: 'Contoh : 12',
                                            change: (value) {
                                              setState(() {
                                                formList[index]['filling'] =
                                                    value;
                                              });
                                            },
                                            typeInput: TextInputType.number,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 0, right: 0.w),
                                        title: Text(
                                          '',
                                          style: subtitleTextBlack,
                                        ),
                                        subtitle: Container(
                                          margin: EdgeInsets.only(top: 10.h),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: GroupButton(
                                                isRadio: true,
                                                options: GroupButtonOptions(
                                                  mainGroupAlignment:
                                                      MainGroupAlignment.start,
                                                  spacing: 5.w,
                                                  selectedColor: PRIMARY_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                onSelected:
                                                    (value, index, isSelected) {
                                                  print(
                                                      'DATA KLIK : $value - $index - $isSelected');
                                                  setState(() {
                                                    formList[index]
                                                            ['filiing1'] =
                                                        index + 1;
                                                  });
                                                },
                                                buttons: const [
                                                  'Psi',
                                                  "Bar",
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 80.h,
                                child: ListTile(
                                  title: Text(
                                    'Pilih Unit',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.topLeft,
                                    child: Consumer<ProviderItem>(
                                      builder: (context, provider, child) {
                                        final unit = provider.units?.data
                                            .map((data) => {
                                                  'id': data.id,
                                                  'name': data.name
                                                })
                                            .toList();

                                        return CustomDropdown(
                                          decoration: CustomDropdownDecoration(
                                              closedBorder: Border.all(
                                                  color: Colors.grey.shade400),
                                              expandedBorder: Border.all(
                                                  color: Colors.grey.shade400)),
                                          hintText: 'Pilih Unit',
                                          items: unit
                                                  ?.map((e) => e['name'])
                                                  .toList() ??
                                              [],
                                          onChanged: (value) {
                                            print("Selected Unit: $unit");

                                            final selected = unit?.firstWhere(
                                              (e) => e['name'] == value,
                                            );

                                            setState(() {
                                              selectUnitId = int.parse(
                                                  selected!['id'].toString());
                                            });

                                            setState(() {
                                              formList[index]['unit'] =
                                                  selectUnitId;
                                            });

                                            print("Selected ID: $selectUnitId");
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 100.h,
                                child: ListTile(
                                  title: Text(
                                    'Harga Satuan',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    child: WidgetForm(
                                      change: (value) {
                                        setState(() {
                                          formList[index]['harga'] = value;
                                        });
                                      },
                                      alert: 'Harga Satuan',
                                      hint: 'Harga Satuan',
                                      typeInput: TextInputType.number,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                height: 40.h,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: WidgetButtonCustom(
                                      FullWidth: width * 0.9,
                                      FullHeight: 40.h,
                                      title: 'Hapus Form',
                                      onpressed: () {
                                        _removeForm(index);
                                      },
                                      bgColor: SECONDARY_COLOR,
                                      color: SECONDARY_COLOR),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              Container(
                width: width * 0.905,
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Align(
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: 40.h,
                      title: 'Tambah Form Produk',
                      onpressed: _addForm,
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
            ] else
              const SizedBox.shrink(),
            SizedBox(
              height: 10.h,
            ),
            if (follow.value == "Send Quotation") ...[
              (formListB.isEmpty)
                  ? Container(
                      width: width,
                      margin:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        'Form Item Kosong',
                        style: superTitleTextBlack,
                      )),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: formListB.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                height: 25.h,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  'List Item ${index + 1}',
                                  style: superTitleTextBlack,
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: width,
                                height: 80.h,
                                child: ListTile(
                                  title: Text(
                                    'Pilih Item',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.topLeft,
                                    child: Consumer<ProviderItem>(
                                      builder: (context, provider, child) {
                                        final item = provider.allItem!.data!
                                            .map((data) => {
                                                  'id': data.id,
                                                  'name': data.name
                                                })
                                            .toList();

                                        return CustomDropdown(
                                          decoration: CustomDropdownDecoration(
                                              closedBorder: Border.all(
                                                  color: Colors.grey.shade400),
                                              expandedBorder: Border.all(
                                                  color: Colors.grey.shade400)),
                                          hintText: 'Pilih Unit',
                                          items: item
                                                  .map((e) => e['name'])
                                                  .toList() ??
                                              [],
                                          onChanged: (value) {
                                            print("Selected item: $item");

                                            final selected = item.firstWhere(
                                              (e) => e['name'] == value,
                                            );

                                            setState(() {
                                              selectItemId = int.parse(
                                                  selected['id'].toString());
                                            });

                                            setState(() {
                                              formList[index]['item'] =
                                                  selectItemId;
                                            });

                                            print("Selected ID: $selectItemId");
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 100.h,
                                child: ListTile(
                                  title: Text(
                                    'Harga Satuan',
                                    style: subtitleTextBlack,
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    child: WidgetForm(
                                      change: (value) {
                                        setState(() {
                                          formListB[index]['harga'] = value;
                                        });
                                      },
                                      alert: 'Harga Satuan',
                                      hint: 'Harga Satuan',
                                      typeInput: TextInputType.number,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                height: 40.h,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: WidgetButtonCustom(
                                      FullWidth: width * 0.9,
                                      FullHeight: 40.h,
                                      title: 'Hapus Form',
                                      onpressed: () {
                                        _removeFormB(index);
                                      },
                                      bgColor: SECONDARY_COLOR,
                                      color: SECONDARY_COLOR),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              Container(
                width: width * 0.905,
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Align(
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: 40.h,
                      title: 'Tambah Form Item',
                      onpressed: _addFormB,
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
            ] else
              const SizedBox.shrink(),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: WidgetButtonCustom(
            FullWidth: width * 0.9,
            FullHeight: height * 0.05,
            title: 'Kirim',
            onpressed: () async {
              if (follow.value == null || controller == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Harap isi semua field yang diperlukan")),
                );
                return;
              }

              int status = 0;
              switch (follow.value) {
                case 'Product Knowledge':
                  status = 2;
                  break;
                case 'Send Quotation':
                  status = 3;
                  break;
                case 'Reminder Response':
                  status = 4;
                  break;
                case 'Negotiation':
                  status = 5;
                  break;
                case 'Visiting':
                  status = 6;
                  break;
              }

              String note = controller!.document.toPlainText();

              if (follow.value == "Send Quotation") {
                List<Map<String, dynamic>> items = formListB.map((item) {
                  return {
                    "item_id": selectItemId, // Gantilah sesuai pilihan pengguna
                    "hpp": int.parse(item['harga'] ?? '0'),
                  };
                }).toList();

                List<Map<String, dynamic>> products = formList.map((product) {
                  return {
                    "product_id":
                        selectProdukId, // Gantilah sesuai pilihan pengguna
                    "hpp": int.parse(product['harga'] ?? '0'),
                    "unit_id": selectUnitId, // Gantilah sesuai pilihan pengguna
                    "gas_purify": int.parse(product['gas'] ?? '0'),
                    "cylinder_volume": int.parse(product['cylinder'] ?? '0'),
                    "filling_pressure": int.parse(product['filling'] ?? '0'),
                    "filling_pressure_type":
                        product['filiing1'] ?? 1, // 1 = psi, 2 = bar
                  };
                }).toList();
                await provider.createFollowUp(
                    context, status, note, items, products, widget.id);
              } else {
                print(note);
                await provider.createFollowUp(
                    context, status, note, [], [], widget.id);
              }
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
