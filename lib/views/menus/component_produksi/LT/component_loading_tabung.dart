import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';

class ComponentLoadingTabung extends StatefulWidget {
  @override
  _ComponentLoadingTabungState createState() => _ComponentLoadingTabungState();
}

class _ComponentLoadingTabungState extends State<ComponentLoadingTabung>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showForm = false;

  Map<String, dynamic> dataF = {
    'EW': '10',
    'Rak': 'A1',
    'FW': '5',
    'Solven': '-',
    'date': '12 Agustus 2024',
    'time': '10.30.00',
    'creator': 'user',
  };

  Map<String, dynamic> data = {
    'EW': '10',
    'Rak': '-',
    'FW': '-',
    'Solven': '-',
    'date': '12 Agustus 2024',
    'time': '10.30.00',
    'creator': 'user',
  };

  Map<String, dynamic> dataS = {
    'EW': '-',
    'Rak': '-',
    'FW': '-',
    'Solven': '-',
    'date': '',
    'time': '',
    'creator': '',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Jumlah tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'C2H2',
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        back: true,
        center: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Search bar
                Container(
                  width: width * 0.9,
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
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: GroupButton(
                isRadio: true,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                },
                buttons: ['Produksi', "QC"]),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          // TabBar untuk navigasi
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Empty\nWeight"),
              Tab(text: "Siap\nProduksi"),
              Tab(text: "Filled\nWeight"),
              Tab(text: "Selesai\nProduksi"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Konten untuk setiap tab
                _buildEmptyWeightTab(width, height),
                _buildSiapProduksiTab(width, height),
                _buildFilledWeightTab(width, height),
                _buildSelesaiProduksiTab(width, height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWeightTab(double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("ACC");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/scan.svg',
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Scan Isi')
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoCard(width: width, height: height, data: data),
          if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
            const SizedBox(height: 16),
          if (_showForm) _buildWeightForm(),
        ],
      ),
    );
  }

  Widget _buildSiapProduksiTab(double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildInfoCard(width: width, height: height, data: dataS),
          if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
            const SizedBox(height: 16),
          if (_showForm) _buildWeightForm(),
        ],
      ),
    );
  }

  Widget _buildFilledWeightTab(double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("ACC");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/scan.svg',
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Scan Isi')
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoCard(width: width, height: height, data: dataF),
          if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
            const SizedBox(height: 16),
          if (_showForm) _buildWeightFormFilled(),
        ],
      ),
    );
  }

  Widget _buildSelesaiProduksiTab(double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Center(child: Text('Status'))),
              Expanded(child: Center(child: Text('OK'))),
              Expanded(child: Center(child: Text('99'))),
              Expanded(child: Center(child: Text('1'))),
              Expanded(
                child: Center(child: Text('NO')),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                flex: 4,
                child: LinearProgressIndicator(
                  value: 9 / 10,
                  color: PRIMARY_COLOR,
                  minHeight: height * 0.01,
                  backgroundColor: SECONDARY_COLOR,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoCard(
              width: width,
              height: height,
              data: dataF,
              showMaintenanceButton: false,
              isOkay: true),
          if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
            const SizedBox(height: 16),
          if (_showForm) _buildWeightFormFilled(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    bool showMaintenanceButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool isOkay = false,
  }) {
    return Container(
      width: double.infinity,
      height: height * 0.2,
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
          if (isOkay == true)
            _buildListItemHeaderS(width, 'No 1234', 'OK', '36.8'),
          if (isOkay == false) _buildListItemHeader(width, 'No 1234'),
          _buildListItemBody(width, height, data, showMaintenanceButton,
              (isOkay) == true ? true : false),
          _buildListItemFooter(width, height, data),
        ],
      ),
    );
  }

  Widget _buildListItemHeader(double width, String no) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: width * 0.3,
            decoration: const BoxDecoration(
              color: PRIMARY_COLOR,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                no,
                style: titleText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeaderS(
      double width, String no, String status, String tw) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Stack(
        children: [
          // Bagian hijau (OK)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width * 0.45, // Lebar hingga setengah layar
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Warna hijau
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Bagian biru (No. 12345)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width * 0.3, // 30% dari lebar layar
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF12163A), // Warna biru tua
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(30),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                no,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Bagian kanan (TW: 36.8)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'TW: $tw',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemBody(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          // Container kiri
          Container(
            width: width * 0.2,
            margin: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Konten kanan
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // Baris atas
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: FittedBox(
                              child:
                                  Text('Prefill', style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text('EW', style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Text(': ${data['EW'] ?? "-"}',
                              style: subtitleTextBlack)),
                      Expanded(
                          flex: 1,
                          child: FittedBox(
                              child: Text('Solven', style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Text(': ${data['Solven'] ?? "-"}',
                              style: subtitleTextBlack)),
                      WidgetButtonCustom(
                        FullWidth: width * 0.25,
                        FullHeight: height * 0.03,
                        title: 'Lihat Riwayat',
                        onpressed: () {},
                        bgColor: PRIMARY_COLOR,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                // Baris tengah
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: FittedBox(
                              child: Text('Production',
                                  style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text('Rak', style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Text(': ${data['Rak'] ?? "-"}',
                              style: subtitleTextBlack)),
                      if (showMaintenanceButton == false)
                        Expanded(flex: 2, child: SizedBox.shrink()),
                      // Kondisional untuk tombol Maintenance
                      if (showMaintenanceButton)
                        WidgetButtonCustom(
                          FullWidth: width * 0.25,
                          FullHeight: height * 0.03,
                          title: 'Maintenance',
                          onpressed: () {},
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent,
                        ),
                    ],
                  ),
                ),
                // Baris bawah
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: (fm == true)
                              ? FittedBox(
                                  child: Text('Postfill',
                                      style: subtitleTextBlack))
                              : Text('Postfill', style: subtitleTextBlack)),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text('FW', style: subtitleTextBlack))),
                      Expanded(
                          flex: 1,
                          child: Text(': ${data['FW'] ?? "-"}',
                              style: subtitleTextBlack)),
                      if (fm == true)
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text('FM', style: subtitleTextBlack))),
                      if (fm == true)
                        Expanded(
                            flex: 1,
                            child: Text(': ${data['FW'] ?? "-"}',
                                style: subtitleTextBlack)),
                      WidgetButtonCustom(
                        FullWidth: width * 0.25,
                        FullHeight: height * 0.03,
                        title: 'Isi Data',
                        onpressed: () {
                          setState(() {
                            _showForm = !_showForm; // Toggle tampilan form
                          });
                        },
                        bgColor: PRIMARY_COLOR,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemFooter(
    double width,
    double height,
    Map<String, dynamic> data,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.5,
            height: height * 0.03,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                "${data['date'] ?? "-"}  ${data['time'] ?? "-"} ${data['creator'] != '' ? 'Created by' : ''}  ${data['creator'] ?? "unknown"}",
                style: TextStyle(
                    fontFamily: "Manrope", color: Colors.grey.shade500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  "Tare Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  "Empty Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width * 0.25,
          FullHeight: MediaQuery.of(context).size.height * 0.03,
          title: 'Submit',
          onpressed: () {},
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildWeightFormFilled() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  "Filled Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                "Status",
                style: subtitleTextBlack,
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GroupButton(
                    isRadio: true,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                    },
                    buttons: ['OK', "NO"]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width * 0.25,
          FullHeight: MediaQuery.of(context).size.height * 0.03,
          title: 'Submit',
          onpressed: () {},
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildTextField({required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
