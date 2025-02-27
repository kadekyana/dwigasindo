import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/menu_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentLoadingTabung extends StatefulWidget {
  ComponentLoadingTabung({super.key, required this.title});
  String title;

  @override
  _ComponentLoadingTabungState createState() => _ComponentLoadingTabungState();
}

class _ComponentLoadingTabungState extends State<ComponentLoadingTabung>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedCardIndex;
  Set<int> expandedCards = {};
  bool _showForm = false;

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  late Map<int, StreamController<ModelLoadingTube>> _streamControllers;

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    // Inisialisasi StreamController untuk setiap status (tab)
    _streamControllers = {
      0: StreamController<ModelLoadingTube>.broadcast(),
      1: StreamController<ModelLoadingTube>.broadcast(),
      2: StreamController<ModelLoadingTube>.broadcast(),
      3: StreamController<ModelLoadingTube>.broadcast(),
    };

    // Mulai stream untuk setiap tab
    _startStream(0);
    _startStream(1);
    _startStream(2);
    _startStream(3);

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      final currentIndex = _tabController.index;

      // Mulai stream untuk tab yang aktif
      _startStream(currentIndex);
    });
  }

  void _startStream(int status) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_streamControllers[status]!.isClosed) {
        final data = await Provider.of<ProviderProduksi>(context, listen: false)
            .getTubeLoading(context, status);
        _streamControllers[status]!.add(data);
      }
    });
  }

  void _stopStream(int status) {
    _streamControllers[status]?.close();
  }

  @override
  void dispose() {
    // Tutup semua StreamController
    _tabController.dispose();
    for (var controller in _streamControllers.values) {
      controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
                controller: menu,
                isRadio: true,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                  setState(() {
                    selectMenu = index == 0;

                    // Reset TabBar setiap kali menu berubah
                    _tabController.index = 0;
                  });
                  print(selectMenu);
                },
                buttons: const ['Produksi', "QC"]),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          // TabBar untuk navigasi
          (selectMenu == true)
              ? TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Empty\nWeight"),
                    Tab(text: "Siap\nProduksi"),
                    Tab(text: "Filled\nWeight"),
                    Tab(text: "Selesai\nProduksi"),
                  ],
                )
              : TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Selesai\nProduksi"),
                    Tab(text: "Kondisi"),
                  ],
                ),
          (selectMenu == true)
              ? Expanded(
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
                )
              : Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Konten untuk setiap tab
                      _buildSelesaiProduksiQCTab(width, height),
                      _buildKondisiTab(width, height),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildSelesaiProduksiQCTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScan(
                            title: 'QC',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    isOkay: true,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'EW': dataTube.emptyWeight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'FW': dataTube.filledWeight ?? "-",
                                      'TW': dataTube.tareWeight ?? "-",
                                      'status': "OK",
                                      'Solven': "-",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      // if (_selectedCardIndex != index ||
                                      //     !_showForm) {
                                      //   setState(() {
                                      //     _selectedCardIndex = index;
                                      //     _showForm = true;
                                      //   });
                                      //   _stopStream(
                                      //       0); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      // } else {
                                      //   setState(() {
                                      //     _showForm = false;
                                      //   });
                                      //   _startStream(
                                      //       0); // Lanjutkan stream setelah selesai
                                      // }
                                    },
                                    // ),
                                    // if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                    //   const SizedBox(height: 16),
                                    // if (_showForm)
                                    //   _buildWeightForm(dataTube.idStr!
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildKondisiTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: (data.tubeLoadingDetail?.length != 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: WidgetButtonCustom(
                              FullWidth: 150.w,
                              FullHeight: 35.h,
                              title: "Publish Produksi",
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IsiDataLoadingTubeQC(
                                        title: "${widget.title} QC"),
                                  ),
                                );
                              },
                              bgColor: PRIMARY_COLOR,
                              color: PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                flex: 1, child: Center(child: Text('Status'))),
                            const Expanded(child: Center(child: Text('OK'))),
                            Expanded(
                                child:
                                    Center(child: Text("${data.tubeOkCount}"))),
                            Expanded(
                                child:
                                    Center(child: Text("${data.tubeNoCount}"))),
                            const Expanded(
                              child: Center(child: Text('NO')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 1, child: SizedBox.shrink()),
                            Expanded(
                              flex: 4,
                              child: LinearProgressIndicator(
                                value: data.tubeOkCount! / data.tubeNoCount!,
                                color: PRIMARY_COLOR,
                                minHeight: height * 0.01,
                                backgroundColor: SECONDARY_COLOR,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];

                              return Column(
                                children: [
                                  _buildInfoCardKondisi(
                                    isOkay: true,
                                    width: width,
                                    height: height,
                                    showIsiDataButton: false,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'EW': dataTube.emptyWeight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'FW': dataTube.filledWeight ?? "-",
                                      'TW': dataTube.tareWeight ?? "-",
                                      'status': (dataTube.tubeStatus == 0)
                                          ? "NO"
                                          : "OK",
                                      'Solven': "-",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    isExpanded: expandedCards.contains(index),
                                    onToggleExpand: () {
                                      setState(() {
                                        if (expandedCards.contains(index)) {
                                          expandedCards.remove(index);
                                        } else {
                                          expandedCards.add(index);
                                        }
                                      });
                                    },
                                    onIsiDataPressed: () {
                                      if (_selectedCardIndex != index ||
                                          !_showForm) {
                                        setState(() {
                                          _selectedCardIndex = index;
                                          _showForm = true;
                                        });
                                        _stopStream(3);
                                      } else {
                                        setState(() {
                                          _showForm = false;
                                        });
                                        _startStream(3);
                                      }
                                    },
                                  ),
                                  if (_showForm && _selectedCardIndex == index)
                                    const SizedBox(height: 16),
                                  if (_showForm && _selectedCardIndex == index)
                                    _buildWeightFormFilled(dataTube.tareWeight!,
                                        dataTube.emptyWeight!, dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                      'Belum Terdapat Data',
                      style: titleTextBlack,
                    )),
                  ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildEmptyWeightTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[0]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuScan(
                                    title: 'Tube',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'EW': dataTube.emptyWeight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'FW': dataTube.filledWeight ?? "-",
                                      'TW': "-",
                                      'status': "OK",
                                      'Solven': "-",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      if (_selectedCardIndex != index ||
                                          !_showForm) {
                                        setState(() {
                                          _selectedCardIndex = index;
                                          _showForm = true;
                                        });
                                        _stopStream(
                                            0); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      } else {
                                        setState(() {
                                          _showForm = false;
                                        });
                                        _startStream(
                                            0); // Lanjutkan stream setelah selesai
                                      }
                                    },
                                  ),
                                  if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                    const SizedBox(height: 16),
                                  if (_showForm)
                                    _buildWeightForm(dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: subtitleTextBlack,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: const Center(child: Text(":")),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Masukkan $label',
                contentPadding: const EdgeInsets.all(8.0),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSiapProduksiTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[1]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          print(data.tubeLoadingDetail?.length);
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: (data.tubeLoadingDetail?.length != 0)
                  ? ListView.builder(
                      itemCount: data.tubeLoadingDetail!.length,
                      itemBuilder: (context, index) {
                        final dataTube = data.tubeLoadingDetail![index];
                        print(dataTube.tubeNo);
                        return _buildInfoCard(
                          width: width,
                          height: height,
                          data: {
                            "id": dataTube.idStr ?? "-",
                            "tube": dataTube.tubeId ?? "-",
                            "no": dataTube.tubeNo ?? "-",
                            'EW': dataTube.emptyWeight ?? "-",
                            'Rak': (dataTube.tubeShelfName == null)
                                ? "-"
                                : dataTube.tubeShelfName,
                            'FW': dataTube.filledWeight ?? "-",
                            'TW': "-",
                            'status': "OK",
                            'Solven': "-",
                            'date': "-",
                            'time': "-",
                            'creator': "-",
                          },
                          onIsiDataPressed: () {
                            if (_selectedCardIndex != index || !_showForm) {
                              setState(() {
                                _selectedCardIndex = index;
                                _showForm = true;
                              });
                              _stopStream(
                                  1); // Hentikan stream untuk tab Empty Weight (status = 0)
                            } else {
                              setState(() {
                                _showForm = false;
                              });
                              _startStream(
                                  1); // Lanjutkan stream setelah selesai
                            }
                          },
                          showIsiDataButton: false,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                      'Belum Terdapat Data',
                      style: titleTextBlack,
                    )),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildFilledWeightTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[2]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuScan(
                                    title: 'Tube',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'EW': dataTube.emptyWeight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'FW': dataTube.filledWeight ?? "-",
                                      'TW': "-",
                                      'status': "OK",
                                      'Solven': "-",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      if (_selectedCardIndex != index ||
                                          !_showForm) {
                                        setState(() {
                                          _selectedCardIndex = index;
                                          _showForm = true;
                                        });
                                        _stopStream(
                                            2); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      } else {
                                        setState(() {
                                          _showForm = false;
                                        });
                                        _startStream(
                                            2); // Lanjutkan stream setelah selesai
                                      }
                                    },
                                  ),
                                  if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                    const SizedBox(height: 16),
                                  if (_showForm)
                                    _buildWeightFormFilled(dataTube.tareWeight!,
                                        dataTube.emptyWeight!, dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildSelesaiProduksiTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: (data.tubeLoadingDetail?.length != 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                flex: 1, child: Center(child: Text('Status'))),
                            const Expanded(child: Center(child: Text('OK'))),
                            Expanded(
                                child:
                                    Center(child: Text('${data.tubeOkCount}'))),
                            Expanded(
                                child:
                                    Center(child: Text('${data.tubeNoCount}'))),
                            const Expanded(
                              child: Center(child: Text('NO')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 1, child: SizedBox.shrink()),
                            Expanded(
                              flex: 4,
                              child: LinearProgressIndicator(
                                value: data.tubeOkCount! / data.tubeNoCount!,
                                color: PRIMARY_COLOR,
                                minHeight: height * 0.01,
                                backgroundColor: SECONDARY_COLOR,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: data.tubeLoadingDetail!.length,
                                itemBuilder: (context, index) {
                                  final dataTube =
                                      data.tubeLoadingDetail![index];
                                  print(dataTube.tubeNo);
                                  return Column(
                                    children: [
                                      _buildInfoCard(
                                        isOkay: true,
                                        width: width,
                                        height: height,
                                        data: {
                                          "id": dataTube.idStr ?? "-",
                                          "tube": dataTube.tubeId ?? "-",
                                          "no": dataTube.tubeNo ?? "-",
                                          'EW': dataTube.emptyWeight ?? "-",
                                          'Rak': dataTube.tubeShelfName ?? "-",
                                          'FW': dataTube.filledWeight ?? "-",
                                          'TW': dataTube.tareWeight ?? "-",
                                          'status': (dataTube.tubeStatus == 0)
                                              ? "NO"
                                              : "Ok",
                                          'Solven': "-",
                                          'date': "-",
                                          'time': "-",
                                          'creator': "-",
                                        },
                                        onIsiDataPressed: () {
                                          if (_selectedCardIndex != index ||
                                              !_showForm) {
                                            setState(() {
                                              _selectedCardIndex = index;
                                              _showForm = true;
                                            });
                                            _stopStream(
                                                3); // Hentikan stream untuk tab Empty Weight (status = 0)
                                          } else {
                                            setState(() {
                                              _showForm = false;
                                            });
                                            _startStream(
                                                3); // Lanjutkan stream setelah selesai
                                          }
                                        },
                                      ),
                                      if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                        const SizedBox(height: 16),
                                      if (_showForm)
                                        _buildWeightFormFilled(
                                            dataTube.tareWeight!,
                                            dataTube.emptyWeight!,
                                            dataTube.idStr!),
                                    ],
                                  );
                                })),
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                      'Belum Terdapat Data',
                      style: titleTextBlack,
                    )),
                  ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildInfoCard({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    bool showMaintenanceButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool showIsiDataButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
  }) {
    final provider = Provider.of<ProviderProduksi>(context);
    return Container(
      width: width,
      height: 160.h,
      margin: EdgeInsets.only(
        top: height * 0.01,
        bottom: height * 0.01,
      ),
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
          (isOkay == true)
              ? _buildListItemHeaderS(width, data)
              : _buildListItemHeader(width, data),
          _buildListItemBody(width, height, data, showMaintenanceButton,
              (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30,
                      title: 'Riwayat',
                      onpressed: () async {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                (showMaintenanceButton)
                    ? Expanded(
                        child: WidgetButtonCustom(
                          FullWidth:
                              (showIsiDataButton) ? width * 0.25 : width * 0.35,
                          FullHeight: 30,
                          title: 'Maintenance',
                          onpressed: () async {
                            await provider.createMaintenance(
                                context, 2, data['no'].toString());
                          },
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent,
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  width: width * 0.01,
                ),
                (showIsiDataButton)
                    ? Expanded(
                        child: WidgetButtonCustom(
                          FullWidth: width * 0.25,
                          FullHeight: 30,
                          title: 'Isi Data',
                          onpressed: onIsiDataPressed,
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardKondisi({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    required bool isExpanded,
    required VoidCallback onToggleExpand,
    bool showMaintenanceButton = true,
    bool showIsiDataButton = true,
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
  }) {
    return Container(
      width: width,
      height: isExpanded ? 400.h : 200.h,
      margin: EdgeInsets.only(
        top: height * 0.01,
        bottom: height * 0.01,
      ),
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
          (isOkay == true)
              ? _buildListItemHeaderS(width, data)
              : _buildListItemHeader(width, data),
          _buildListItemBody(width, height, data, showMaintenanceButton,
              (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth:
                        (showIsiDataButton) ? width * 0.25 : width * 0.35,
                    FullHeight: 30,
                    title: 'Riwayat',
                    onpressed: () async {},
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(width: width * 0.01),
                if (showMaintenanceButton)
                  Expanded(
                    child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30,
                      title: 'Maintenance',
                      onpressed: () {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent,
                    ),
                  ),
                SizedBox(width: width * 0.01),
                if (showIsiDataButton)
                  Expanded(
                    child: WidgetButtonCustom(
                      FullWidth: width * 0.25,
                      FullHeight: 30,
                      title: 'Isi Data',
                      onpressed: onIsiDataPressed,
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          if (isExpanded)
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      const Divider(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Pengecekan",
                              style: titleTextBlack,
                            ),
                            // Container(
                            //   width: 35.w,
                            //   height: 40.h,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(100.w),
                            //       color: SECONDARY_COLOR),
                            //   child: FittedBox(
                            //     fit: BoxFit.scaleDown,
                            //     child: Text(
                            //       "FAIL",
                            //       style: subtitleText,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: 35.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: Colors.green),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "PASS",
                                  style: subtitleText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Text('Tabung Bawah',
                                    style: minisubtitleTextBlack)),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Safety Flug',
                                        style: minisubtitleTextBlack))),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Tekanan (17 - 19) bar',
                                    style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child: Text('18', style: minisubtitleTextBlack),
                            ),
                            Expanded(
                                child:
                                    Text('Pen', style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Text('Body Tabung',
                                    style: minisubtitleTextBlack)),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Isi Gas(Kg)',
                                        style: minisubtitleTextBlack))),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  Text('10000', style: minisubtitleTextBlack),
                            ),
                            Expanded(
                                child: Text('Teflon',
                                    style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Kaki Tabung',
                                    style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child:
                                    Text('Krop', style: minisubtitleTextBlack)),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Tutup Tabung',
                                        style: minisubtitleTextBlack))),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Draft Valve',
                                    style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('', style: minisubtitleTextBlack)),
                            const Text(''),
                            Expanded(
                              child: Text(
                                "",
                                style: minisubtitleTextNormal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Dibuat oleh',
                                    style: minisubtitleTextNormal),
                              ),
                            ),
                            const Text(':\t'),
                            Expanded(
                              flex: 2,
                              child: Align(
                                child: Text(
                                  "Dwi Gitayana Putra",
                                  style: minisubtitleTextNormal,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              child: Text('Dibuat pada',
                                  style: minisubtitleTextNormal),
                            )),
                            const Text(':\t'),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "11 - 8 - 2024 | 10 : 30",
                                  style: minisubtitleTextNormal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: WidgetButtonCustom(
                                FullWidth: (showIsiDataButton)
                                    ? width * 0.25
                                    : width * 0.35,
                                FullHeight: 40.h,
                                title: 'COA',
                                onpressed: () async {},
                                bgColor: PRIMARY_COLOR,
                                color: Colors.transparent,
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            if (showMaintenanceButton)
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: (showIsiDataButton)
                                      ? width * 0.25
                                      : width * 0.35,
                                  FullHeight: 40.h,
                                  title: 'Edit Data',
                                  onpressed: () {},
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          IconButton(
            icon: Icon(isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
            onPressed: onToggleExpand,
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeader(double width, Map<String, dynamic> data) {
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
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                data['no'].toString(),
                style: titleText,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Dibuat oleh: -', style: subtitleTextNormal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeaderS(
    double width,
    Map<String, dynamic> data,
  ) {
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
              decoration: BoxDecoration(
                color: (data['status'].toString() == "NO")
                    ? SECONDARY_COLOR
                    : const Color(0xFF4CAF50), // Warna hijau
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(15)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(data['status'].toString(), style: titleText),
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
              child: Text(data['no'].toString(), style: titleText),
            ),
          ),

          // Bagian kanan (TW: 36.8)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.scaleDown,
                      child: Text('TW: ${data['TW'].toString()}',
                          style: minisubtitleTextBlack),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.topRight,
                      fit: BoxFit.scaleDown,
                      child: Text('Dibuat Oleh: User 1',
                          style: minisubtitleTextNormal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemBodyKondisi(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: width * 0.2,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Prefill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('EW', style: subtitleTextBlack))),
                        const Text(':\t'),
                        Expanded(
                          child: Text('${data['EW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        Expanded(
                            child: Text('Solven', style: subtitleTextBlack)),
                        const Text(':'),
                        Expanded(
                          child: Text('\t -', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Production', style: subtitleTextBlack)),
                        Expanded(child: Text('Rak', style: subtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: subtitleTextBlack),
                        ),
                        Expanded(child: Text('', style: subtitleTextBlack)),
                        const Text(''),
                        Expanded(
                          child: Text('', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Postfill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('FW', style: subtitleTextBlack))),
                        const Text(':\t'),
                        Expanded(
                          child: Text('${data['FW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        (fm == true)
                            ? Expanded(
                                child: Text('FM', style: subtitleTextBlack))
                            : const Expanded(child: SizedBox.shrink()),
                        (fm == true) ? const Text(':') : const Text(''),
                        (fm == true)
                            ? Expanded(
                                child: Text('\t${data['FM'] ?? "-"}',
                                    style: subtitleTextBlack),
                              )
                            : const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Dibuat Pada', style: subtitleTextNormal)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('-', style: subtitleTextNormal))),
                        const Expanded(child: SizedBox.shrink()),
                        const Expanded(child: SizedBox.shrink()),
                        const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemBody(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: width * 0.2,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Prefill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('EW', style: subtitleTextBlack))),
                        const Text(':\t'),
                        Expanded(
                          child: Text('${data['EW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        Expanded(
                            child: Text('Solven', style: subtitleTextBlack)),
                        const Text(':'),
                        Expanded(
                          child: Text('\t -', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Production', style: subtitleTextBlack)),
                        Expanded(child: Text('Rak', style: subtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: subtitleTextBlack),
                        ),
                        Expanded(child: Text('', style: subtitleTextBlack)),
                        const Text(''),
                        Expanded(
                          child: Text('', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Postfill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('FW', style: subtitleTextBlack))),
                        const Text(':\t'),
                        Expanded(
                          child: Text('${data['FW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        (fm == true)
                            ? Expanded(
                                child: Text('FM', style: subtitleTextBlack))
                            : const Expanded(child: SizedBox.shrink()),
                        (fm == true) ? const Text(':') : const Text(''),
                        (fm == true)
                            ? Expanded(
                                child: Text('\t${data['FM'] ?? "-"}',
                                    style: subtitleTextBlack),
                              )
                            : const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Dibuat Pada', style: subtitleTextNormal)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('-', style: subtitleTextNormal))),
                        const Expanded(child: SizedBox.shrink()),
                        const Expanded(child: SizedBox.shrink()),
                        const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightForm(String idStr) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Tare Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: tare,
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
                fit: BoxFit.scaleDown,
                child: Text(
                  "Empty Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: empty,
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                  onSubmit: () {
                    Provider.of<ProviderProduksi>(context, listen: false)
                        .updateDataLoadingTube(context, int.parse(tare.text),
                            int.parse(empty.text), 0, 2, idStr);
                    setState(() {
                      _showForm = false;
                    });
                  },
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
          onpressed: () {
            Provider.of<ProviderProduksi>(context, listen: false)
                .updateDataLoadingTube(context, int.parse(tare.text),
                    int.parse(empty.text), 0, 2, idStr);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }

  Widget _buildWeightFormFilled(int tw, int ew, String idStr) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Filled Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: tare,
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
                child: const Center(child: Text(":"))),
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
                    buttons: const ['OK', "NO"]),
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
          onpressed: () {
            Provider.of<ProviderProduksi>(context, listen: false)
                .updateDataLoadingTube(
                    context, tw, ew, int.parse(tare.text), 3, idStr);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
      ],
    );
  }

  // Widget _buildTextField({required String label}) {
  //   return TextField(
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //     keyboardType: TextInputType.number,
  //   );
  // }
}

class IsiDataLoadingTubeQC extends StatefulWidget {
  IsiDataLoadingTubeQC({super.key, required this.title});
  String title;

  @override
  State<IsiDataLoadingTubeQC> createState() => _IsiDataLoadingTubeQCState();
}

class _IsiDataLoadingTubeQCState extends State<IsiDataLoadingTubeQC> {
  GroupButtonController? jenis = GroupButtonController(selectedIndex: 0);
  TextEditingController? nomorPo = TextEditingController();
  TextEditingController? namaPelanggan = TextEditingController();
  TextEditingController? jumlah = TextEditingController();
  TextEditingController? name = TextEditingController();
  bool check = true;
  int? selectTubeGas;
  List<Map<String, dynamic>>? tubeGas;

  bool selectJenis = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final provider = Provider.of<ProviderDistribusi>(context, listen: false);
  //   tubeGas = provider.tubeGas?.data
  //       .map((data) => {'id': data.id, 'name': data.name})
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Isi Data ${widget.title}',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text('Berat Isi TW1 (Kg)', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'contoh : 10',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text('Tekanan (Bar/Psi)', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'contoh : 10',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Mulut Valve',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Badan Tabung',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Safety Valve',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Pen',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Status Inspeksi',
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
                        },
                        buttons: const ['Pass', "Fail"]),
                  ),
                ),
              ),
            if (widget.title == "Inspeksi" || widget.title == "CO2 Inspeksi")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text('Keterangan', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'Keterangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Tabung Bawah',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Teflon',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Pen',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Krop',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Draft Valve',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Safety Flug',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Body Tabung',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Kaki Tabung',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Tutup Tabung',
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
                        },
                        buttons: const ['Good', "Not Good"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title:
                      Text('Tekanan (17 - 19) bar', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'Contoh : 10',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text('Isi Gas (Kg)', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'Contoh : 10',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text(
                    'Status Inspeksi',
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
                        },
                        buttons: const ['Pass', "Fail"]),
                  ),
                ),
              ),
            if (widget.title == "C2H2 QC")
              SizedBox(
                width: width,
                child: ListTile(
                  title: Text('Keterangan', style: subtitleTextBlack),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: name,
                      alert: 'Harus Diisi',
                      hint: 'Keterangan',
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
        padding: const EdgeInsets.all(10),
        child: WidgetButtonCustom(
            FullWidth: width * 0.93,
            FullHeight: height * 0.06,
            title: (selectJenis == true) ? "Submit & Mulai Scan" : 'Submit',
            onpressed: () async {
              (widget.title == 'C2H2')
                  ? await provider.createProduksi(
                      context,
                      jenis!.selectedIndex,
                      nomorPo!.text,
                      name!.text,
                      namaPelanggan!.text,
                      int.parse(jumlah!.text))
                  : await provider.createMixGas(
                      context,
                      jenis!.selectedIndex,
                      nomorPo!.text,
                      name!.text,
                      namaPelanggan!.text,
                      int.parse(jumlah!.text),
                      selectTubeGas);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
