import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_seles_information.dart';
import 'package:dwigasindo/views/menus/component_sales/component_tugas.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentMenuSalesInformationDetail extends StatelessWidget {
  const ComponentMenuSalesInformationDetail({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(text: 'List'),
      const Tab(text: 'Tugas Kunjungan'),
    ];

    final List<Widget> tabViews = [
      ComponentMenuSelesInformation(title: title),
      ComponentTugas(title: title),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(kToolbarHeight + kTextTabBarHeight),
          child: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.grey.shade100,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}

class ComponentMenuProdukMasterCustomer extends StatefulWidget {
  ComponentMenuProdukMasterCustomer({super.key, required this.id});

  int id;

  @override
  State<ComponentMenuProdukMasterCustomer> createState() =>
      _ComponentMenuProdukMasterCustomerState();
}

class _ComponentMenuProdukMasterCustomerState
    extends State<ComponentMenuProdukMasterCustomer> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);
    final data = provider.produkCmd?.data;
    print("length ${data?.length}");
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            WidgetButtonCustom(
              FullWidth: width,
              FullHeight: 40.h,
              title: "Tambah Produk",
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentTambahProduk(
                      title: 'Tambah Produk',
                      id: widget.id,
                    ),
                  ),
                );
              },
              bgColor: PRIMARY_COLOR,
              color: Colors.transparent,
            ),
            SizedBox(
              height: 12.h,
            ),
            (data?.length == 0)
                ? const Expanded(
                    child: Center(
                      child: Text("Belum Terdapat Data"),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final dataC = data[index];

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
                              SizedBox(
                                width: double.maxFinite,
                                height: 40.h,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 120.w, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color:
                                              PRIMARY_COLOR, // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(dataC.name ?? "No Name",
                                            style: titleText),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.35,
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: FittedBox(
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "Dibuat Oleh : ${dataC.createdBy ?? "Unknown"}",
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
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Grade',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${(dataC.isGrade == true) ? providerDis.getGrade(dataC.gradeId ?? 0) : "-"}',
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
                                                      child: Text('Catatan',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${dataC.note ?? "-"}',
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
                                                      child: Text('Harga',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${(dataC.price != null) ? provider.formatCurrency(dataC.price as num) : "0"}',
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
                                                      child: Text('Dibuat Pada',
                                                          style:
                                                              subtitleTextNormalGrey),
                                                    ),
                                                  ),
                                                  Text(':',
                                                      style:
                                                          subtitleTextNormalGrey),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${provider.formatDate(dataC.createdAt?.toString() ?? "")} | ${provider.formatTime(dataC.createdAt?.toString() ?? "")}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalGrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, bottom: 5.h),
                                  child: WidgetButtonCustom(
                                    FullWidth: width,
                                    FullHeight: 40.h,
                                    title: "Lihat",
                                    onpressed: () {},
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent,
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

class ComponentTambahProduk extends StatefulWidget {
  ComponentTambahProduk({super.key, required this.title, required this.id});
  String title;
  int id;
  @override
  State<ComponentTambahProduk> createState() => _ComponentTambahProdukState();
}

class _ComponentTambahProdukState extends State<ComponentTambahProduk> {
  GroupButtonController? jenis = GroupButtonController();
  TextEditingController hpp = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController note = TextEditingController();
  bool cek = false;
  bool tlp = false;
  int? produk;
  int? selectItem;
  bool? isSelect;

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
                  'Jenis Produk',
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
                        setState(() {
                          if (index == 2) {
                            isSelect = true;
                          } else {
                            isSelect = false;
                          }
                        });
                      },
                      buttons: const ['Gas', "Jasa", "Item"]),
                ),
              ),
            ),
            if (isSelect == false)
              Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(
                    'Pilih Produk',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderOrder>(
                      builder: (context, provider, child) {
                        final pic = provider.produk!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Produk',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              produk = int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $produk");
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (isSelect == true)
              Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(
                    'Pilih Item',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderItem>(
                      builder: (context, provider, child) {
                        final pic = provider.allItem!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Item',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              selectItem = int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $selectItem");
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
              child: ListTile(
                title: Text(
                  'HPP',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: hpp,
                    change: (value) {},
                    alert: 'HPP',
                    hint: 'HPP',
                    typeInput: TextInputType.number,
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
                  'Harga',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: harga,
                    change: (value) {},
                    alert: 'Harga',
                    hint: 'Harga',
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
                print((jenis!.selectedIndex! + 1));
                print(produk);
                print(selectItem);
                if (isSelect == false) {
                  provider.createTambahProdukCostumer(
                      context,
                      widget.id,
                      (jenis!.selectedIndex! + 1),
                      null,
                      produk!,
                      double.parse(hpp.text),
                      double.parse(harga.text),
                      note.text);
                } else {
                  provider.createTambahProdukCostumer(
                      context,
                      widget.id,
                      (jenis!.selectedIndex! + 1),
                      selectItem!,
                      null,
                      double.parse(hpp.text),
                      double.parse(harga.text),
                      note.text);
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
