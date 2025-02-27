import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/produksi/component_isi_data.dart';
import 'package:dwigasindo/views/menus/menu_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentDetailRakMixGas extends StatefulWidget {
  ComponentDetailRakMixGas(
      {super.key, required this.title, this.idRak, required this.idStr});
  String title;
  int? idRak;
  String? idStr;

  @override
  State<ComponentDetailRakMixGas> createState() =>
      _ComponentDetailRakMixGasState();
}

class _ComponentDetailRakMixGasState extends State<ComponentDetailRakMixGas> {
  TextEditingController jumlahGas = TextEditingController();

  // Variabel global untuk menyimpan state tombol
  List<bool> buttonStates = [
    true, // Start Produksi (aktif default)
    false, // Selesai Produksi (disable default)
    false, // Spray (disable default)
    false, // Control Produksi (disable default)
  ];

  void _showCustomModal(BuildContext context, double width, double height) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Fungsi untuk mengatur logika tombol
            void handleButtonClick(int index) {
              if (index == 0) {
                // Logika untuk Start Produksi
                setModalState(() {
                  Provider.of<ProviderProduksi>(context, listen: false)
                      .updateStatus(context, widget.idStr!, 1);
                  buttonStates[0] = false; // Start Produksi jadi disable
                  buttonStates[1] = true; // Selesai Produksi aktif
                  buttonStates[2] = true; // Spray aktif
                  buttonStates[3] = true; // Control Produksi aktif
                });
              } else if (index == 1) {
                // Logika untuk Selesai Produksi
                Provider.of<ProviderProduksi>(context, listen: false)
                    .updateStatusOnSubmit(context, widget.idStr!, 6);
                setModalState(() {
                  buttonStates[0] = false; // Start Produksi tetap disable
                  buttonStates[1] = true; // Selesai Produksi tetap aktif
                  buttonStates[2] = true; // Spray tetap aktif
                  buttonStates[3] = true; // Control Produksi tetap aktif
                });
                // Menampilkan tombol baru
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Pilih Aksi Lanjutan', style: subtitleTextBlack),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<ProviderProduksi>(context,
                                          listen: false)
                                      .updateStatusOnSubmit(
                                          context, widget.idStr!, 7);
                                  Navigator.pop(context); // Lanjut Produksi
                                  Navigator.pop(context); // Lanjut Produksi
                                  Navigator.pop(context); // Lanjut Produksi
                                },
                                child: const Text('Lanjut Produksi'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<ProviderProduksi>(context,
                                          listen: false)
                                      .updateStatus(context, widget.idStr!, 0);
                                  Provider.of<ProviderProduksi>(context,
                                          listen: false)
                                      .updateStatusOnSubmit(
                                          context, widget.idStr!, 8);
                                  Navigator.pop(context); // Off Compressor
                                  Navigator.pop(context); // Off Compressor
                                  Navigator.pop(context); // Off Compressor
                                  Navigator.pop(context); // Off Compressor
                                  Provider.of<ProviderProduksi>(context,
                                          listen: false)
                                      .getAllProduksi(context);
                                },
                                child: const Text('Off Compressor'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ).whenComplete(() {
                  // Ketika kembali dari modal tombol baru
                  setModalState(() {
                    buttonStates[1] = true; // Selesai Produksi tetap aktif
                    buttonStates[2] = true; // Spray tetap aktif
                    buttonStates[3] = true; // Control Produksi tetap aktif
                  });
                });
              } else if (index == 2) {
                // Logika untuk Spray
                Provider.of<ProviderProduksi>(context, listen: false)
                    .updateStatusOnSubmit(context, widget.idStr!, 4);
                setModalState(() {
                  buttonStates[0] = true; // Start Produksi aktif kembali
                  buttonStates[1] = false; // Selesai Produksi disable
                  buttonStates[2] = false; // Spray disable
                  buttonStates[3] = false; // Control Produksi disable
                });
              } else if (index == 3) {
                Provider.of<ProviderProduksi>(context, listen: false)
                    .updateStatusOnSubmit(context, widget.idStr!, 5);
                // Logika untuk Control Produksi
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ControlProduksiPage(), // Ganti sesuai page Anda
                //   ),
                // );
              }
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pilih Aksi', style: titleTextBlack),
                  SizedBox(height: height * 0.01),
                  // Daftar tombol
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: buttonStates.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final labels = [
                        'Start Produksi',
                        'Selesai Produksi',
                        'Spray',
                        'Control Produksi'
                      ];
                      return ElevatedButton(
                        onPressed: buttonStates[index]
                            ? () => handleButtonClick(index)
                            : null, // Disable tombol jika false
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonStates[index]
                              ? Colors.blue.shade900
                              : Colors.grey.shade400,
                        ),
                        child: Text(
                          labels[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: buttonStates[index]
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Ketika modal ditutup, kondisi tombol tetap disimpan
      // Tidak ada perubahan pada buttonStates
    });
  }

  void _showCustomModalDetail(
    BuildContext context,
    double width,
    double height,
    String tubeNo,
    int activeState, // 0 untuk Filling, 1 untuk Refilling
    String id,
  ) {
    // State awal untuk mengelola tombol berdasarkan activeState
    bool isFillingEnabled = activeState == 1;
    bool isRefillingEnabled = activeState == 0;
    bool isEmptyEnabled = true; // Empty selalu aktif
    print(activeState);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Fungsi untuk Filling
            void handleFilling() async {
              final provider =
                  Provider.of<ProviderProduksi>(context, listen: false);

              // Simpan logika pengolahan Filling di sini
              await provider.updateRefillingTube(context, tubeNo, 0, 0);
              await provider.getIsiRak(context, widget.idRak, [0]);
              Navigator.pop(context);
            }

            // Fungsi untuk menampilkan form isi gas (Refilling)
            void showRefillingForm() {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                isScrollControlled:
                    true, // Penting untuk menyesuaikan dengan keyboard
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context)
                          .unfocus(); // Menutup keyboard jika area di luar form diklik
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                      ), // Menambahkan padding untuk menghindari keyboard
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Isi Gas (Refilling)', style: titleTextBlack),
                            const SizedBox(height: 16),
                            TextField(
                              controller: jumlahGas,
                              decoration: const InputDecoration(
                                labelText: 'Jumlah Gas',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType
                                  .number, // Tampilkan keyboard angka
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final provider = Provider.of<ProviderProduksi>(
                                    context,
                                    listen: false);

                                // Panggil function untuk update data
                                await provider.updateRefillingTube(context,
                                    tubeNo, 1, int.parse(jumlahGas.text));
                                await provider
                                    .getIsiRak(context, widget.idRak, [0]);
                                jumlahGas.clear();
                                Navigator.pop(context); // Tutup form Refilling
                                Navigator.pop(context); // Tutup modal utama
                              },
                              child: const Text('Simpan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            // Fungsi untuk menampilkan konfirmasi hapus (Empty)
            void showEmptyConfirmation() {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const Text(
                        'Apakah Anda yakin ingin menghapus tabung gas ini?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                        },
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final provider = Provider.of<ProviderProduksi>(
                              context,
                              listen: false);

                          // Panggil function untuk update data
                          await provider.deleteTube(context, id);
                          await provider.getIsiRak(context, widget.idRak, [0]);
                          // Logika untuk menghapus tabung gas
                          Navigator.pop(context); // Tutup dialog
                          Navigator.pop(context); // Tutup modal utama
                        },
                        child: const Text('Hapus'),
                      ),
                    ],
                  );
                },
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pilih Aksi', style: titleTextBlack),
                  SizedBox(height: 16.h),
                  // Daftar tombol
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final labels = ['Filling', 'Refilling', 'Empty'];
                      final functions = [
                        handleFilling, // Filling
                        showRefillingForm, // Refilling
                        showEmptyConfirmation, // Empty
                      ];
                      final isEnabled = [
                        isFillingEnabled, // Kondisi Filling
                        isRefillingEnabled, // Kondisi Refilling
                        isEmptyEnabled, // Kondisi Empty
                      ];

                      return ElevatedButton(
                        onPressed: isEnabled[index] ? functions[index] : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isEnabled[index]
                              ? Colors.blue.shade900
                              : Colors.grey.shade400,
                        ),
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            color: isEnabled[index]
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleButtonClick(
      int index, List<bool> buttonStates, StateSetter setModalState) {
    if (index == 3) {
      // Logika jika tombol "Start Produksi" ditekan
      setModalState(() {
        for (int i = 0; i < buttonStates.length; i++) {
          buttonStates[i] = false; // Nonaktifkan semua tombol
        }
        buttonStates[6] = true; // Aktifkan tombol "Spray"
      });
    } else if (index == 6) {
      // Logika jika tombol "Spray" ditekan
      setModalState(() {
        for (int i = 0; i < buttonStates.length; i++) {
          buttonStates[i] = false; // Nonaktifkan semua tombol
        }
      });
      Future.delayed(const Duration(seconds: 2), () {
        setModalState(() {
          for (int i = 0; i < buttonStates.length; i++) {
            buttonStates[i] = i < 6; // Reset tombol ke kondisi awal
          }
          buttonStates[6] = false; // Spray tetap disable
          buttonStates[7] = false; // Control Produksi tetap disable
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ID Rak : ${widget.idRak}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);
    return Scaffold(
        appBar: WidgetAppbar(
          title: widget.title,
          center: true,
          colorTitle: Colors.black,
          colorBack: Colors.black,
          colorBG: Colors.grey.shade100,
          back: true,
          route: () {
            Provider.of<ProviderProduksi>(context, listen: false)
                .getAllProduksi(context);
            Navigator.pop(context);
          },
        ),
        body: (provider.isLoading == true)
            ? const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
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
                    Align(
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
                          buttons: const ['List', 'History']),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuScan(
                              title: widget.title,
                              idRak: widget.idRak,
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
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Scan Isi')
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: (provider.allTubeShelfMixGas?.data?.length == null)
                          ? Center(
                              child: Text(
                                'Belum Terdapat Data\nSilahkan Scan Terlebih Dahulu',
                                textAlign: TextAlign.center,
                                style: titleTextBlack,
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 2,
                              ),
                              itemCount: provider.allTubeShelfMixGas?.data
                                  ?.length, // jumlah data dummy
                              itemBuilder: (context, index) {
                                final data =
                                    provider.allTubeShelfMixGas?.data![index];
                                return ElevatedButton(
                                  onPressed: () async {
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
                                        provider.getDataIsi(
                                            context, data.idStr!)
                                      ]);

                                      // Navigate sesuai kondisi
                                      Navigator.of(context)
                                          .pop(); // Tutup Dialog Loading
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ComponentIsiData(
                                            idStr: data.idStr!,
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
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PRIMARY_COLOR,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(data!.tubeNo!, style: titleText),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetButtonCustom(
                  FullWidth: width * 0.4,
                  FullHeight: height * 0.06,
                  title: 'Start Produksi',
                  onpressed: () async {},
                  bgColor: PRIMARY_COLOR,
                  color: PRIMARY_COLOR),
              WidgetButtonCustom(
                  FullWidth: width * 0.4,
                  FullHeight: height * 0.06,
                  title: 'Selesai',
                  onpressed: () async {},
                  titleColor: const TextStyle(color: Colors.black),
                  bgColor: Colors.white,
                  color: Colors.grey.shade300),
            ],
          ),
        ));
  }
}
