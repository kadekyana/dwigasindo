import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_data_master_customer.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ComponentDataMasterCustomer extends StatefulWidget {
  ComponentDataMasterCustomer({super.key, required this.title});
  String title;

  @override
  State<ComponentDataMasterCustomer> createState() =>
      _ComponentDataMasterCustomerState();
}

class _ComponentDataMasterCustomerState
    extends State<ComponentDataMasterCustomer> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () async {
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
                  provider.getUsersPic(context),
                  provider.getDistrict(context, ''),
                ]);

                // Navigate sesuai kondisi
                Navigator.of(context).pop(); // Tutup Dialog Loading
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentDetailSales(
                      cekKondisi: true,
                    ),
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop(); // Tutup Dialog Loading
                print('Error: $e');
                // Tambahkan pesan error jika perlu
              }
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: WidgetForm(
                        alert: 'Search',
                        hint: 'Search',
                        border: InputBorder.none,
                        preicon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  // filter bar
                  Expanded(
                      child: Container(
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
                  )),
                ],
              ),
            ),
            Expanded(
              child: (provider.cmd!.data!.length == 0)
                  ? Center(
                      child: Text(
                        'Belum Terdapat Data',
                        style: superTitleTextBlack,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          provider.cmd?.data.length ?? 0, // Pastikan tidak null
                      itemBuilder: (context, index) {
                        final data = provider.cmd?.data[index];

                        if (data == null)
                          return SizedBox(); // Handle jika data null

                        return Container(
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
                              Container(
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
                                            horizontal: 10),
                                        child: Text("Good", style: titleText),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Nama Customer',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${data.name ?? "-"}', // Default "-"
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Kode',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${(data.code == '') ? "-" : data.code}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Lokasi Kota',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${data.districtComplete ?? "-"}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Sales',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${provider.formatCurrency(data.totalOrder ?? 0)}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Lama Kerjasama ',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${data.cooperationSinceToIdn ?? "-"}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: CircularPercentIndicator(
                                                radius: 34.w,
                                                lineWidth: 5,
                                                percent: (data.limitPlatform ==
                                                        0)
                                                    ? 1.0
                                                    : (data.remaining != null &&
                                                            data.remaining! > 0
                                                        ? data.remaining! /
                                                            (data.limitPlatform!
                                                                .toDouble())
                                                        : 0.0),
                                                center: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data.remaining != null &&
                                                              data.remaining! >
                                                                  0
                                                          ? "${data.remaining}"
                                                          : "Habis",
                                                      style:
                                                          minisubtitleTextBlack,
                                                    ),
                                                    Text("Lagi",
                                                        style:
                                                            minisubtitleTextGrey),
                                                  ],
                                                ),
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                progressColor: PRIMARY_COLOR,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                              ),
                                            ),
                                            SizedBox(height: 3.h),
                                            WidgetButtonCustom(
                                              FullWidth: width * 0.3,
                                              FullHeight: 25,
                                              title: "Lihat Data",
                                              onpressed: () async {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                );

                                                try {
                                                  await Future.wait([
                                                    provider.getDetailCMD(
                                                        context, data.id ?? 0),
                                                    provider.getDistrict(
                                                        context, ''),
                                                    provider.getCatatanCmd(
                                                        context, data.id ?? 0),
                                                    provider
                                                        .getDocumentationCMD(
                                                            context,
                                                            data.id ?? 0),
                                                    provider.getProdukCMD(
                                                        context, data.id ?? 0),
                                                    providerDis.getAllTubeGrade(
                                                        context),
                                                    provider.searchProdukGas(
                                                        context),
                                                    provider.getAlokasi(
                                                        context, data.id ?? 0),
                                                    provider.getProyeksi(
                                                        context, data.id ?? 0)
                                                  ]);

                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ComponentMenuDataMasterCustomer(
                                                        title:
                                                            "Detail ${widget.title}",
                                                        id: data.id ?? 0,
                                                      ),
                                                    ),
                                                  );
                                                } catch (e) {
                                                  Navigator.of(context).pop();
                                                  print('Error: $e');
                                                }
                                              },
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent,
                                            ),
                                            SizedBox(height: 5.h),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentDetailSales extends StatefulWidget {
  ComponentDetailSales({super.key, required this.cekKondisi});
  bool cekKondisi;
  @override
  State<ComponentDetailSales> createState() => _ComponentDetailSalesState();
}

class _ComponentDetailSalesState extends State<ComponentDetailSales> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController npwp = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController kecamatan = TextEditingController();
  final TextEditingController jangka = TextEditingController();
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController radius = TextEditingController();
  final TextEditingController limit = TextEditingController();
  final TextEditingController kode = TextEditingController();

  SingleSelectController<String?>? pic1 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic2 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic3 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic4 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic5 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic6 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? bidang =
      SingleSelectController<String?>(null);
  GroupButtonController? jenis = GroupButtonController();
  GroupButtonController? plafon = GroupButtonController();
  GroupButtonController? pengiriman = GroupButtonController();
  GroupButtonController? pengirimanP = GroupButtonController();
  GroupButtonController? pembayaran = GroupButtonController();
  GroupButtonController? invoice = GroupButtonController();
  GroupButtonController? profit = GroupButtonController();
  GroupButtonController? type = GroupButtonController();

  bool cek = false;
  bool tlp = false;
  bool p = true;
  bool b = true;
  int selectId = 0;
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int selectPicId3 = 0;
  int selectPicId4 = 0;
  int selectPicId5 = 0;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        tanggal.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      showSnackBar("Nama Customer harus diisi");
      return false;
    }
    if (codeController.text.isEmpty) {
      showSnackBar("Kode Customer harus diisi");
      return false;
    }
    if (npwp.text.isEmpty) {
      showSnackBar("No. NPWP harus diisi");
      return false;
    }
    if (addressController.text.isEmpty) {
      showSnackBar("Alamat harus diisi");
      return false;
    }
    if (kode.text.isEmpty) {
      showSnackBar("Kode Prefix harus diisi");
      return false;
    }
    if (kecamatan.text.isEmpty) {
      showSnackBar("Kecamatan harus diisi");
      return false;
    }
    if (jangka.text.isEmpty) {
      showSnackBar("Jangka waktu pembayaran harus diisi");
      return false;
    }
    if (tanggal.text.isEmpty) {
      showSnackBar("Tanggal kerja sejak harus diisi");
      return false;
    }
    if (radius.text.isEmpty) {
      showSnackBar("Radius harus diisi");
      return false;
    }
    if (limit.text.isEmpty && cek) {
      // Jika plafon "Terbatas" harus diisi
      showSnackBar("Limit Plafon harus diisi");
      return false;
    }
    if (nohp.text.isEmpty && tlp) {
      // Jika pengiriman "Via Telp" harus diisi
      showSnackBar("Nomor Telepon harus diisi");
      return false;
    }

    if (jenis!.selectedIndex == null) {
      showSnackBar("Jenis Customer harus dipilih");
      return false;
    }
    if (plafon!.selectedIndex == null) {
      showSnackBar("Jenis Plafon harus dipilih");
      return false;
    }
    if (pengiriman!.selectedIndex == null) {
      showSnackBar("Jenis Pengiriman harus dipilih");
      return false;
    }
    if (pengirimanP!.selectedIndex == null) {
      showSnackBar("Permintaan Pengiriman harus dipilih");
      return false;
    }
    if (pembayaran!.selectedIndex == null) {
      showSnackBar("Jenis Pembayaran harus dipilih");
      return false;
    }
    if (invoice!.selectedIndex == null) {
      showSnackBar("Penagihan Invoice harus dipilih");
      return false;
    }
    if (profit!.selectedIndex == null) {
      showSnackBar("Proyeksi Profit harus dipilih");
      return false;
    }

    // Validasi PIC Approval
    if (pic1!.value == null) {
      showSnackBar("PIC Verifikasi harus dipilih");
      return false;
    }
    if (pic2!.value == null) {
      showSnackBar("PIC Mengetahui harus dipilih");
      return false;
    }
    if (pic6!.value == null) {
      showSnackBar("PIC Menyetujui harus dipilih");
      return false;
    }

    // Validasi formList (PIC tambahan)
    for (int i = 0; i < formList.length; i++) {
      if (formList[i]['nama'] == null || formList[i]['nama'].isEmpty) {
        showSnackBar("Nama PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['bagian'] == null || formList[i]['bagian'].isEmpty) {
        showSnackBar("Bagian PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['nomor'] == null || formList[i]['nomor'].isEmpty) {
        showSnackBar("Nomor WA PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['email'] == null || formList[i]['email'].isEmpty) {
        showSnackBar("Email PIC ${i + 1} harus diisi");
        return false;
      }
    }

    // Validasi formListB (Alamat Pengiriman Bertahap)
    for (int i = 0; i < formListB.length; i++) {
      if (formListB[i]['alamat'] == null || formListB[i]['alamat'].isEmpty) {
        showSnackBar("Alamat Pengirim ${i + 1} harus diisi");
        return false;
      }
    }

    return true;
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Data Customer',
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
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Nama Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: nameController,
                    change: (value) {},
                    alert: 'Nama Customer',
                    hint: 'Nama Customer',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kode Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: codeController,
                    change: (value) {},
                    alert: 'Kode Customer',
                    hint: 'Kode Customer',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: jenis,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: ['Perorangan', "Perusahaan"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'No. NPWP',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: npwp,
                    change: (value) {},
                    alert: 'No. NPWP',
                    hint: 'No. NPWP',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Alamat',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: addressController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat di sini...',
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
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                      title: Text(
                        'Kecamatan dan Kota',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Consumer<ProviderSales>(
                          builder: (context, provider, child) {
                            final grade = provider.district?.data
                                ?.map((data) =>
                                    {'id': data.id, 'name': data.name})
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
                                  selectId =
                                      int.parse(selected!['id'].toString());
                                });

                                print("Selected ID: $selectId");
                              },
                              labelText: 'Cari Barang',
                              controller: kecamatan,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 20.w),
                      title: Text(
                        'Radius',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: radius,
                          alert: 'Radius',
                          hint: 'Radius',
                          typeInput: TextInputType.number,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Plafon',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: plafon,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            cek = true;
                          });
                        } else {
                          setState(() {
                            cek = false;
                          });
                        }
                      },
                      buttons: ['Terbatas', "Tidak Terbatas"]),
                ),
              ),
            ),
            if (cek == true)
              SizedBox(
                width: width,
                height: 100.h,
                child: ListTile(
                  title: Text(
                    'Limit Plafon',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: limit,
                      change: (value) {},
                      alert: 'Limit Plafon',
                      hint: 'Limit Plafon',
                      typeInput: TextInputType.number,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pic ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeForm(index),
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 16.w, right: 5.w),
                              title: Text(
                                'Nama',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  change: (value) {
                                    setState(() {
                                      formList[index]['nama'] = value;
                                    });
                                  },
                                  alert: 'Nama',
                                  hint: 'Nama',
                                  typeInput: TextInputType.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding: EdgeInsets.only(right: 20.w),
                              title: Text(
                                'Bagian',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  change: (value) {
                                    setState(() {
                                      formList[index]['bagian'] = value;
                                    });
                                  },
                                  alert: 'Bagian',
                                  hint: 'Bagian',
                                  typeInput: TextInputType.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 16.w, right: 5.w),
                              title: Text(
                                'Nomor Wa',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  change: (value) {
                                    setState(() {
                                      formList[index]['nomor'] = value;
                                    });
                                  },
                                  alert: 'Nomor Wa',
                                  hint: 'Nomor Wa',
                                  typeInput: TextInputType.number,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding: EdgeInsets.only(right: 20.w),
                              title: Text(
                                'Email',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  change: (value) {
                                    setState(() {
                                      formList[index]['email'] = value;
                                    });
                                  },
                                  alert: 'Email',
                                  hint: 'Email',
                                  typeInput: TextInputType.emailAddress,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Pic',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Pengiriman',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pengiriman,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            p = true;
                          });
                        } else {
                          setState(() {
                            p = false;
                          });
                        }
                      },
                      buttons: ['Dikirim', "Diambil Sendiri"]),
                ),
              ),
            ),
            if (p == true)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: formListB.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Alamat Pengirim ${index + 1}',
                                style: titleTextBlack,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                onPressed: () => _removeFormB(),
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        height: 100.h,
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 16.w, right: 20.w),
                          title: Text(
                            'Alamat',
                            style: subtitleTextBlack,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            height: 70.h,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  formListB[index]['alamat'] = value;
                                });
                              },
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                hintText: 'Masukkan alamat di sini...',
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
                  );
                },
              ),
            if (p == true)
              SizedBox(
                height: 10.h,
              ),
            if (p == true)
              Container(
                width: width,
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: 40.h,
                      title: 'Tambah Form Alamat Pengirim',
                      onpressed: _addFormB,
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Permintaan Pengiriman',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pengirimanP,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 1) {
                          setState(() {
                            tlp = true;
                          });
                        } else {
                          setState(() {
                            tlp = false;
                          });
                        }
                      },
                      buttons: ['PO', "Via Telp"]),
                ),
              ),
            ),
            if (tlp == true)
              SizedBox(
                width: width,
                height: 100.h,
                child: ListTile(
                  title: Text(
                    'Via Telp',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: nohp,
                      change: (value) {},
                      alert: 'Masukkan no telp',
                      hint: 'Masukkan no telp',
                      typeInput: TextInputType.number,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            Container(
              width: width,
              height: 120.h,
              child: ListTile(
                title: Text(
                  'Jenis Pembayaran',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pembayaran,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: [
                        'Cash',
                        "COD",
                        "Credit",
                        "Transfer Bank",
                        "Warkat"
                      ]),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Penagihan Invoice',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: invoice,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            b = true;
                          });
                        } else {
                          setState(() {
                            b = false;
                          });
                        }
                      },
                      buttons: [
                        'Bertahap',
                        "Tutup PO",
                      ]),
                ),
              ),
            ),
            if (b == true)
              Container(
                width: width,
                height: 100.h,
                child: Row(
                  children: [
                    Container(
                      width: 210.w,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                        title: Text(
                          'Jangka Waktu Pembayaran',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: jangka,
                            alert: 'Contoh : 12',
                            hint: 'Contoh : 12',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150.w,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 0.w),
                        title: Text(
                          '',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GroupButton(
                                controller: type,
                                isRadio: true,
                                options: GroupButtonOptions(
                                  mainGroupAlignment: MainGroupAlignment.start,
                                  buttonWidth: 65.w,
                                  selectedColor: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onSelected: (value, index, isSelected) {
                                  print(
                                      'DATA KLIK : $value - $index - $isSelected');
                                },
                                buttons: [
                                  'Hari',
                                  "Bulan",
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
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kode Preflix Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: kode,
                    change: (value) {},
                    alert: 'Kode Preflix',
                    hint: 'Kode Preflix',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kerja Sejak',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: tanggal,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: const Icon(Icons.calendar_month)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Apakah Menggunakan Proyeksi Profit',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: profit,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: [
                        'Ya',
                        "Tidak",
                      ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width,
                height: 420.h,
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
                            controller: pic1,
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
                            controller: pic2,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Consumer<ProviderSales>(
                        builder: (context, provider, child) {
                          final pic = provider.modelUsersPic!.data!
                              .map((data) => {'id': data.id, 'name': data.name})
                              .toList();

                          return CustomDropdown(
                            controller: pic3,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId2 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId2");
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
                            controller: pic4,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId3 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId3");
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
                            controller: pic5,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId4 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId4");
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
                            controller: pic6,
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
                                selectPicId5 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId5");
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
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
              onpressed: () async {
                if (validateForm()) {
                  print("✅ Data valid, mengirim ke API...");
                  final plusJ = jenis!.selectedIndex! + 1;
                  final plusPP = pengiriman!.selectedIndex! + 1;
                  final plusPPP = pengirimanP!.selectedIndex! + 1;
                  final plusPPPP = pembayaran!.selectedIndex! + 1;
                  final plusI = invoice!.selectedIndex! + 1;
                  final plusT = type!.selectedIndex! + 1;
                  final provider =
                      Provider.of<ProviderSales>(context, listen: false);

                  await provider.createCustomer(
                    context,
                    nameController.text,
                    addressController.text,
                    codeController.text,
                    npwp.text,
                    selectId, // Konversi ke int jika perlu
                    double.tryParse(radius.text) ?? 0.0,
                    cek,
                    double.tryParse(limit.text) ?? 0.0,
                    plusJ ?? 0,
                    plusPP ?? 0,
                    plusPPP == 2 ? "Via Telp" : "PO",
                    nohp.text,
                    plusPPPP ?? 0,
                    plusI ?? 0,
                    plusT ??
                        0, // Belum ada field untuk paymentTermType, default 0
                    int.parse(jangka.text),
                    kode.text, // tubePrefix belum tersedia
                    profit!.selectedIndex == 1,
                    tanggal.text,
                    formList
                        .map((e) => {
                              "name": e["nama"] ?? "",
                              "department": e["bagian"] ?? "",
                              "phone": e["nomor"] ?? "",
                              "email": e["email"] ?? "",
                            })
                        .toList(),
                    formListB
                        .map((e) => {
                              "address": e["alamat"] ?? "",
                            })
                        .toList(),
                    selectPicId,
                    selectPicId1,
                    selectPicId2,
                    selectPicId3,
                    selectPicId4,
                    selectPicId5,
                  );
                } else {
                  print("❌ Ada data yang belum diisi, periksa kembali!");
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class ComponentEditDetail extends StatefulWidget {
  ComponentEditDetail({super.key, required this.id});
  final int id;
  @override
  State<ComponentEditDetail> createState() => _ComponentEditDetailState();
}

class _ComponentEditDetailState extends State<ComponentEditDetail> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController npwp = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController kecamatan = TextEditingController();
  final TextEditingController jangka = TextEditingController();
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController radius = TextEditingController();
  final TextEditingController limit = TextEditingController();
  final TextEditingController kode = TextEditingController();
  final TextEditingController namaPic = TextEditingController();
  final TextEditingController bagianPic = TextEditingController();
  final TextEditingController waPic = TextEditingController();
  final TextEditingController emailPic = TextEditingController();
  final TextEditingController alamatAla = TextEditingController();

  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int selectPicId3 = 0;
  int selectPicId4 = 0;
  int selectPicId5 = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderSales>(context, listen: false);
    final detail = provider.detailCMD?.data;

    if (detail != null) {
      nameController.text = detail.name ?? "";
      addressController.text = detail.address ?? "";
      codeController.text = detail.code ?? "";
      npwp.text = detail.npwp ?? "";
      nohp.text = detail.deliveryRequestPhone ?? "";
      kecamatan.text = detail.districtId?.toString() ?? "";
      jangka.text = detail.paymentTerm?.toString() ?? "";
      tanggal.text = (detail.cooperationSince != null)
          ? provider.formatDate(detail.cooperationSince.toString())
          : "-";
      radius.text = detail.radius?.toString() ?? "";
      limit.text = detail.limitPlatform?.toString() ?? "";
      kode.text = detail.tubePrefix ?? "";

      // Set GroupButton
      jenis!.selectIndex((detail.typeCoorporation != null)
          ? (detail.typeCoorporation! - 1)
          : 0);
      plafon!.selectIndex(detail.isLimitPlatform == true ? 0 : 1);
      pengiriman!.selectIndex(
          (detail.typeDelivery != null) ? (detail.typeDelivery! - 1) : 0);
      pengirimanP!.selectIndex(detail.deliveryRequestBy == "Via Telp" ? 1 : 0);
      pembayaran!.selectIndex(
          (detail.typePayment != null) ? (detail.typePayment! - 1) : 0);
      invoice!.selectIndex(
          (detail.typeInvoice != null) ? (detail.typeInvoice! - 1) : 0);
      profit!.selectIndex(detail.isProyeksiProfit == true ? 0 : 1);
      type!.selectIndex(
          (detail.paymentTermType != null) ? (detail.paymentTermType! - 1) : 0);

      // Set PIC tambahan
      if (detail.pics != null) {
        formList = detail.pics
                ?.map((pic) => {
                      "nama": pic.name ?? "",
                      "bagian": pic.department ?? "",
                      "nomor": pic.phone ?? "",
                      "email": pic.email ?? "",
                    })
                .toList() ??
            [];
        namaPic.text =
            detail.pics?.isNotEmpty == true ? detail.pics![0].name ?? "" : "";
        bagianPic.text = detail.pics?.isNotEmpty == true
            ? detail.pics![0].department ?? ""
            : "";
        waPic.text =
            detail.pics?.isNotEmpty == true ? detail.pics![0].phone ?? "" : "";
        emailPic.text =
            detail.pics?.isNotEmpty == true ? detail.pics![0].email ?? "" : "";
      }
      if (detail.addressesList != null) {
        formListB = detail.addressesList
                ?.map((addr) => {
                      "alamat": addr.address ?? "",
                    })
                .toList() ??
            [];
        alamatAla.text = detail.addressesList?.isNotEmpty == true
            ? detail.addressesList![0].address ?? ""
            : "";
      }
      // Set Alamat Bertahap
      String getNameById(int id) {
        final pic = provider.modelUsersPic!.data!
            .map((data) => {'id': data.id, 'name': data.name})
            .toList();
        // Mencari data dengan ID yang sesuai
        final selected = pic.firstWhere(
          (e) => e['id'] == id,
        );
        return selected['name'].toString();
      }

      // // // Isi data ke controller
      pic1!.value =
          (detail.approval1 != null) ? getNameById(detail.approval1!) : null;
      pic2!.value =
          (detail.approval2 != null) ? getNameById(detail.approval2!) : null;
      pic3!.value =
          (detail.approval3 != null) ? getNameById(detail.approval3!) : null;
      pic4!.value =
          (detail.approval4 != null) ? getNameById(detail.approval4!) : null;
      pic5!.value =
          (detail.approval5 != null) ? getNameById(detail.approval5!) : null;
      pic6!.value =
          (detail.approval6 != null) ? getNameById(detail.approval6!) : null;
    }
  }

  SingleSelectController<String?>? pic1 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic2 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic3 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic4 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic5 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? pic6 = SingleSelectController<String?>(null);
  SingleSelectController<String?>? bidang =
      SingleSelectController<String?>(null);
  GroupButtonController? jenis = GroupButtonController();
  GroupButtonController? plafon = GroupButtonController();
  GroupButtonController? pengiriman = GroupButtonController();
  GroupButtonController? pengirimanP = GroupButtonController();
  GroupButtonController? pembayaran = GroupButtonController();
  GroupButtonController? invoice = GroupButtonController();
  GroupButtonController? profit = GroupButtonController();
  GroupButtonController? type = GroupButtonController();

  bool cek = false;
  bool tlp = false;
  bool p = true;
  bool b = true;
  int selectId = 0;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        tanggal.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      showSnackBar("Nama Customer harus diisi");
      return false;
    }
    if (codeController.text.isEmpty) {
      showSnackBar("Kode Customer harus diisi");
      return false;
    }
    if (npwp.text.isEmpty) {
      showSnackBar("No. NPWP harus diisi");
      return false;
    }
    if (addressController.text.isEmpty) {
      showSnackBar("Alamat harus diisi");
      return false;
    }
    if (kode.text.isEmpty) {
      showSnackBar("Kode Prefix harus diisi");
      return false;
    }
    if (kecamatan.text.isEmpty) {
      showSnackBar("Kecamatan harus diisi");
      return false;
    }
    if (jangka.text.isEmpty) {
      showSnackBar("Jangka waktu pembayaran harus diisi");
      return false;
    }
    if (tanggal.text.isEmpty) {
      showSnackBar("Tanggal kerja sejak harus diisi");
      return false;
    }
    if (radius.text.isEmpty) {
      showSnackBar("Radius harus diisi");
      return false;
    }
    if (limit.text.isEmpty && cek) {
      // Jika plafon "Terbatas" harus diisi
      showSnackBar("Limit Plafon harus diisi");
      return false;
    }
    if (nohp.text.isEmpty && tlp) {
      // Jika pengiriman "Via Telp" harus diisi
      showSnackBar("Nomor Telepon harus diisi");
      return false;
    }

    if (jenis!.selectedIndex == null) {
      showSnackBar("Jenis Customer harus dipilih");
      return false;
    }
    if (plafon!.selectedIndex == null) {
      showSnackBar("Jenis Plafon harus dipilih");
      return false;
    }
    if (pengiriman!.selectedIndex == null) {
      showSnackBar("Jenis Pengiriman harus dipilih");
      return false;
    }
    if (pengirimanP!.selectedIndex == null) {
      showSnackBar("Permintaan Pengiriman harus dipilih");
      return false;
    }
    if (pembayaran!.selectedIndex == null) {
      showSnackBar("Jenis Pembayaran harus dipilih");
      return false;
    }
    if (invoice!.selectedIndex == null) {
      showSnackBar("Penagihan Invoice harus dipilih");
      return false;
    }
    if (profit!.selectedIndex == null) {
      showSnackBar("Proyeksi Profit harus dipilih");
      return false;
    }

    // Validasi PIC Approval
    if (pic1!.value == null) {
      showSnackBar("PIC Verifikasi harus dipilih");
      return false;
    }
    if (pic2!.value == null) {
      showSnackBar("PIC Mengetahui harus dipilih");
      return false;
    }
    if (pic6!.value == null) {
      showSnackBar("PIC Menyetujui harus dipilih");
      return false;
    }

    // Validasi formList (PIC tambahan)
    for (int i = 0; i < formList.length; i++) {
      if (formList[i]['nama'] == null || formList[i]['nama'] == '') {
        showSnackBar("Nama PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['bagian'] == null || formList[i]['bagian'] == '') {
        showSnackBar("Bagian PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['nomor'] == null || formList[i]['nomor'] == '') {
        showSnackBar("Nomor WA PIC ${i + 1} harus diisi");
        return false;
      }
      if (formList[i]['email'] == null || formList[i]['email'] == '') {
        showSnackBar("Email PIC ${i + 1} harus diisi");
        return false;
      }
    }

    // Validasi formListB (Alamat Pengiriman Bertahap)
    for (int i = 0; i < formListB.length; i++) {
      if (formListB[i]['alamat'] == null || formListB[i]['alamat'] == '') {
        showSnackBar("Alamat Pengirim ${i + 1} harus diisi");
        return false;
      }
    }

    return true;
  }

  List<Map<String, String>> formList = []; // List untuk menyimpan data form
  List<Map<String, String>> formListB = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "nama": "",
        "bagian": "",
        "nomor": "",
        "email": "",
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
      formListB.add({"alamat": ""});
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Nama Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: nameController,
                    change: (value) {},
                    alert: 'Nama Customer',
                    hint: 'Nama Customer',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kode Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: codeController,
                    change: (value) {},
                    alert: 'Kode Customer',
                    hint: 'Kode Customer',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: jenis,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: ['Perorangan', "Perusahaan"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'No. NPWP',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: npwp,
                    change: (value) {},
                    alert: 'No. NPWP',
                    hint: 'No. NPWP',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Alamat',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: addressController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat di sini...',
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
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                      title: Text(
                        'Kecamatan dan Kota',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Consumer<ProviderSales>(
                          builder: (context, provider, child) {
                            final grade = provider.district?.data
                                ?.map((data) =>
                                    {'id': data.id, 'name': data.name})
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
                                  selectId =
                                      int.parse(selected!['id'].toString());
                                });

                                print("Selected ID: $selectId");
                              },
                              labelText: 'Cari Barang',
                              controller: kecamatan,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 20.w),
                      title: Text(
                        'Radius',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: radius,
                          alert: 'Radius',
                          hint: 'Radius',
                          typeInput: TextInputType.number,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Plafon',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: plafon,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            cek = true;
                          });
                        } else {
                          setState(() {
                            cek = false;
                          });
                        }
                      },
                      buttons: ['Terbatas', "Tidak Terbatas"]),
                ),
              ),
            ),
            if (cek == true)
              SizedBox(
                width: width,
                height: 100.h,
                child: ListTile(
                  title: Text(
                    'Limit Plafon',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: limit,
                      change: (value) {},
                      alert: 'Limit Plafon',
                      hint: 'Limit Plafon',
                      typeInput: TextInputType.number,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ...List.generate(
              formList.length,
              (index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pic ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeForm(index),
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 16.w, right: 5.w),
                              title: Text(
                                'Nama',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  controller: namaPic,
                                  change: (value) {
                                    setState(() {
                                      formList[index]['nama'] = value;
                                    });
                                  },
                                  alert: 'Nama',
                                  hint: 'Nama',
                                  typeInput: TextInputType.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding: EdgeInsets.only(right: 20.w),
                              title: Text(
                                'Bagian',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  controller: bagianPic,
                                  change: (value) {
                                    setState(() {
                                      formList[index]['bagian'] = value;
                                    });
                                  },
                                  alert: 'Bagian',
                                  hint: 'Bagian',
                                  typeInput: TextInputType.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 16.w, right: 5.w),
                              title: Text(
                                'Nomor Wa',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  controller: waPic,
                                  change: (value) {
                                    setState(() {
                                      formList[index]['nomor'] = value;
                                    });
                                  },
                                  alert: 'Nomor Wa',
                                  hint: 'Nomor Wa',
                                  typeInput: TextInputType.number,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            height: 100.h,
                            child: ListTile(
                              contentPadding: EdgeInsets.only(right: 20.w),
                              title: Text(
                                'Email',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  controller: emailPic,
                                  change: (value) {
                                    setState(() {
                                      formList[index]['email'] = value;
                                    });
                                  },
                                  alert: 'Email',
                                  hint: 'Email',
                                  typeInput: TextInputType.emailAddress,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Pic',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Pengiriman',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pengiriman,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            p = true;
                          });
                        } else {
                          setState(() {
                            p = false;
                          });
                        }
                      },
                      buttons: ['Dikirim', "Diambil Sendiri"]),
                ),
              ),
            ),
            if (p == true)
              ...List.generate(
                formListB.length,
                (index) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Alamat Pengirim ${index + 1}',
                                style: titleTextBlack,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                onPressed: () => _removeFormB(index),
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        height: 100.h,
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 16.w, right: 20.w),
                          title: Text(
                            'Alamat',
                            style: subtitleTextBlack,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            height: 70.h,
                            child: TextField(
                              controller: alamatAla,
                              onChanged: (value) {
                                setState(() {
                                  formListB[index]['alamat'] = value;
                                });
                              },
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                hintText: 'Masukkan alamat di sini...',
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
                  );
                },
              ),
            if (p == true)
              SizedBox(
                height: 10.h,
              ),
            if (p == true)
              Container(
                width: width,
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: 40.h,
                      title: 'Tambah Form Alamat Pengirim',
                      onpressed: _addFormB,
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Permintaan Pengiriman',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pengirimanP,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 1) {
                          setState(() {
                            tlp = true;
                          });
                        } else {
                          setState(() {
                            tlp = false;
                          });
                        }
                      },
                      buttons: ['PO', "Via Telp"]),
                ),
              ),
            ),
            if (tlp == true)
              SizedBox(
                width: width,
                height: 100.h,
                child: ListTile(
                  title: Text(
                    'Via Telp',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: nohp,
                      change: (value) {},
                      alert: 'Masukkan no telp',
                      hint: 'Masukkan no telp',
                      typeInput: TextInputType.number,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            Container(
              width: width,
              height: 120.h,
              child: ListTile(
                title: Text(
                  'Jenis Pembayaran',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: pembayaran,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: [
                        'Cash',
                        "COD",
                        "Credit",
                        "Transfer Bank",
                        "Warkat"
                      ]),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Penagihan Invoice',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: invoice,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (index == 0) {
                          setState(() {
                            b = true;
                          });
                        } else {
                          setState(() {
                            b = false;
                          });
                        }
                      },
                      buttons: [
                        'Bertahap',
                        "Tutup PO",
                      ]),
                ),
              ),
            ),
            if (b == true)
              Container(
                width: width,
                height: 100.h,
                child: Row(
                  children: [
                    Container(
                      width: 210.w,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                        title: Text(
                          'Jangka Waktu Pembayaran',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: jangka,
                            alert: 'Contoh : 12',
                            hint: 'Contoh : 12',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150.w,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 0.w),
                        title: Text(
                          '',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GroupButton(
                                controller: type,
                                isRadio: true,
                                options: GroupButtonOptions(
                                  mainGroupAlignment: MainGroupAlignment.start,
                                  buttonWidth: 65.w,
                                  selectedColor: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onSelected: (value, index, isSelected) {
                                  print(
                                      'DATA KLIK : $value - $index - $isSelected');
                                },
                                buttons: [
                                  'Hari',
                                  "Bulan",
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
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kode Preflix Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: kode,
                    change: (value) {},
                    alert: 'Kode Preflix',
                    hint: 'Kode Preflix',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Kerja Sejak',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: tanggal,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: const Icon(Icons.calendar_month)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Apakah Menggunakan Proyeksi Profit',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: profit,
                      isRadio: true,
                      options: GroupButtonOptions(
                        mainGroupAlignment: MainGroupAlignment.start,
                        spacing: 5.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: [
                        'Ya',
                        "Tidak",
                      ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width,
                height: 420.h,
                child: ListTile(
                    title: Text(
                      'PIC Approval',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Consumer<ProviderSales>(
                      builder: (context, provider, child) {
                        final pic = provider.modelUsersPic!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return Column(
                          children: [
                            // pic1 dropdown
                            CustomDropdown(
                              controller: pic1,
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
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomDropdown(
                              controller: pic2,
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Mengetahui',
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
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomDropdown(
                              controller: pic3,
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Mengetahui',
                              items: pic.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = pic.firstWhere(
                                  (e) => e['name'] == item,
                                );

                                setState(() {
                                  selectPicId2 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId2");
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomDropdown(
                              controller: pic4,
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Mengetahui',
                              items: pic.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = pic.firstWhere(
                                  (e) => e['name'] == item,
                                );

                                setState(() {
                                  selectPicId3 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId3");
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomDropdown(
                              controller: pic5,
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Mengetahui',
                              items: pic.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = pic.firstWhere(
                                  (e) => e['name'] == item,
                                );

                                setState(() {
                                  selectPicId4 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId4");
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomDropdown(
                              controller: pic6,
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
                                  selectPicId5 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId5");
                              },
                            ),
                          ],
                        );
                      },
                    )),
              ),
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
              title: 'Update Data',
              onpressed: () async {
                if (validateForm()) {
                  print("✅ Data valid, mengirim ke API...");
                  final plusJ = jenis!.selectedIndex! + 1;
                  final plusPP = pengiriman!.selectedIndex! + 1;
                  final plusPPP = pengirimanP!.selectedIndex! + 1;
                  final plusPPPP = pembayaran!.selectedIndex! + 1;
                  final plusI = invoice!.selectedIndex! + 1;
                  final plusT = type!.selectedIndex! + 1;

                  final provider =
                      Provider.of<ProviderSales>(context, listen: false);
                  // print(plusJ);
                  // print(plusPP);
                  // print(plusPPP);
                  // print(plusPPPP);
                  // print(plusI);
                  // print(plusT);
                  await provider.updateCustomer(
                    context,
                    widget.id,
                    nameController.text,
                    addressController.text,
                    codeController.text,
                    npwp.text,
                    selectId, // Konversi ke int jika perlu
                    double.tryParse(radius.text) ?? 0.0,
                    cek,
                    double.tryParse(limit.text) ?? 0.0,
                    plusJ ?? 0,
                    plusPP ?? 0,
                    plusPPP == 2 ? "Via Telp" : "PO",
                    nohp.text,
                    plusPPPP ?? 0,
                    plusI ?? 0,
                    plusT ??
                        0, // Belum ada field untuk paymentTermType, default 0
                    int.parse(jangka.text),
                    kode.text, // tubePrefix belum tersedia
                    profit!.selectedIndex == 1,
                    tanggal.text,
                    formList
                        .map((e) => {
                              "name": e["nama"] ?? "",
                              "department": e["bagian"] ?? "",
                              "phone": e["nomor"] ?? "",
                              "email": e["email"] ?? "",
                            })
                        .toList(),
                    formListB
                        .map((e) => {
                              "address": e["alamat"] ?? "",
                            })
                        .toList(),
                  );
                } else {
                  print("❌ Ada data yang belum diisi, periksa kembali!");
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class ComponentProyeksiProfit extends StatefulWidget {
  ComponentProyeksiProfit({super.key, required this.id});
  final int id;
  @override
  State<ComponentProyeksiProfit> createState() =>
      _ComponentProyeksiProfitState();
}

class _ComponentProyeksiProfitState extends State<ComponentProyeksiProfit> {
  final SingleSelectController<String?>? produkC =
      SingleSelectController<String?>(null);

  final GroupButtonController? jenisVolume = GroupButtonController();
  final GroupButtonController? jenisMargin = GroupButtonController();
  final GroupButtonController? jenisCashback = GroupButtonController();
  final GroupButtonController? gradeC = GroupButtonController();

  final TextEditingController harga = TextEditingController();
  final TextEditingController losses = TextEditingController();
  final TextEditingController limbah = TextEditingController();
  final TextEditingController penolong = TextEditingController();
  final TextEditingController listrik = TextEditingController();
  final TextEditingController volume = TextEditingController();
  final TextEditingController tenaga = TextEditingController();
  final TextEditingController biaya = TextEditingController();
  final TextEditingController hp = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController margin = TextEditingController();
  final TextEditingController pemakaian = TextEditingController();
  final TextEditingController cashback = TextEditingController();
  final TextEditingController investasi = TextEditingController();
  final TextEditingController beli = TextEditingController();
  final TextEditingController umur = TextEditingController();
  final TextEditingController to = TextEditingController();
  final TextEditingController sales = TextEditingController();
  final TextEditingController cradle = TextEditingController();
  final TextEditingController kebutuhan = TextEditingController();
  final TextEditingController stok = TextEditingController();
  final TextEditingController penambahan = TextEditingController();
  final TextEditingController tersedia = TextEditingController();

  bool cek = false;
  int selectId = 0;
  int selectGradeId = 0;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Proyeksi Profit',
        back: true,
        center: true,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
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
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Pilih Produk',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: Consumer<ProviderSales>(
                    builder: (context, provider, child) {
                      final produk = provider.produk!.data!
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        controller: produkC,
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Produk',
                        items: produk.map((e) => e['name']).toList() ?? [],
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = produk.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            selectId = int.parse(selected!['id'].toString());
                          });

                          print("Selected ID: $selectId");
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
                  'Harga Liquid',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: harga,
                    change: (value) {},
                    alert: 'Harga Liquid',
                    hint: 'Harga Liquid',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Losses Produksi',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: losses,
                    change: (value) {},
                    alert: 'Losses Produksi',
                    hint: 'Losses Produksi',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Pengolahan Limbah',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: limbah,
                    change: (value) {},
                    alert: 'Pengolahan Limbah',
                    hint: 'Pengolahan Limbah',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Bahan Penolong',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: penolong,
                    change: (value) {},
                    alert: 'Bahan Penolong',
                    hint: 'Bahan Penolong',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Listrik Maintenance',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: listrik,
                    change: (value) {},
                    alert: 'Listrik Maintenance',
                    hint: 'Listrik Maintenance',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                      title: Text(
                        'Volume Isi Tabung',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: volume,
                          change: (value) {},
                          alert: 'Volume Isi Tabung',
                          hint: 'Volume Isi Tabung',
                          typeInput: TextInputType.text,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 20.w),
                      title: Text(
                        '',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: GroupButton(
                            controller: jenisVolume,
                            isRadio: true,
                            options: GroupButtonOptions(
                              selectedColor: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['Lt', "M3", "Kg"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Tenaga Kerja',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: tenaga,
                    change: (value) {},
                    alert: 'Tenaga Kerja',
                    hint: 'Tenaga Kerja',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Biaya Transport',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: biaya,
                    change: (value) {},
                    alert: 'Biaya Transport',
                    hint: 'Biaya Transport',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'HP Penjualan Tabung VGL / O2',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: hp,
                    change: (value) {},
                    alert: 'HP Penjualan Tabung VGL / O2',
                    hint: 'HP Penjualan Tabung VGL / O2',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Total Cost',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: total,
                    change: (value) {},
                    alert: 'Total Cost',
                    hint: 'Total Cost',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                      title: Text(
                        'Margin',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: margin,
                          change: (value) {},
                          alert: 'Margin',
                          hint: 'Margin',
                          typeInput: TextInputType.text,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 20.w),
                      title: Text(
                        '',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: GroupButton(
                            controller: jenisMargin,
                            isRadio: true,
                            options: GroupButtonOptions(
                              selectedColor: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['%', "Rp"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Pemakaian /bulan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: pemakaian,
                    change: (value) {},
                    alert: 'Pemakaian /bulan',
                    hint: 'Pemakaian /bulan',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16.w, right: 5.w),
                      title: Text(
                        'Cashback',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: WidgetForm(
                          controller: cashback,
                          change: (value) {},
                          alert: 'Cashback',
                          hint: 'Cashback',
                          typeInput: TextInputType.text,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 20.w),
                      title: Text(
                        '',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: GroupButton(
                            controller: jenisCashback,
                            isRadio: true,
                            options: GroupButtonOptions(
                              selectedColor: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['%', "Rp"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Investasi Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: investasi,
                    change: (value) {},
                    alert: 'Investasi Tabung',
                    hint: 'Investasi Tabung',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Harga Beli Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: beli,
                    change: (value) {},
                    alert: 'Harga Beli Tabung',
                    hint: 'Harga Beli Tabung',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'TO Tabung',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: to,
                    change: (value) {},
                    alert: 'TO Tabung',
                    hint: 'TO Tabung',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Umur Ekonomi /bulan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: umur,
                    change: (value) {},
                    alert: 'Umur Ekonomi /bulan',
                    hint: 'Umur Ekonomi /bulan',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 20.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                'Kebutuhan Tabung',
                style: titleTextBlack,
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'TO Tabung/Cradle',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: cradle,
                    change: (value) {},
                    alert: 'TO Tabung/Cradle',
                    hint: 'TO Tabung/Cradle',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
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
              title: 'Tambah Data',
              onpressed: () async {
                provider.createProyeksi(
                    context,
                    widget.id,
                    selectId,
                    double.parse(harga.text),
                    double.parse(losses.text),
                    double.parse(limbah.text),
                    double.parse(penolong.text),
                    double.parse(listrik.text),
                    double.parse(volume.text),
                    jenisVolume!.selectedIndex!,
                    int.parse(tenaga.text),
                    double.parse(biaya.text),
                    double.parse(hp.text),
                    double.parse(total.text),
                    double.parse(margin.text),
                    jenisMargin!.selectedIndex!,
                    double.parse(pemakaian.text),
                    double.parse(cashback.text),
                    jenisCashback!.selectedIndex!,
                    double.parse(investasi.text),
                    double.parse(beli.text),
                    double.parse(to.text),
                    double.parse(cradle.text),
                    int.parse(umur.text));
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
