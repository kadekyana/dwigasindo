import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ComponentDetailRak extends StatefulWidget {
  const ComponentDetailRak({super.key});

  @override
  State<ComponentDetailRak> createState() => _ComponentDetailRakState();
}

class _ComponentDetailRakState extends State<ComponentDetailRak> {
  void _showCustomModal(BuildContext context, double width, double height) {
    // State awal untuk mengelola tombol di modal
    List<bool> buttonStates = [
      true, // Filing
      true, // Refilling
      true, // Empty
      true, // Start Produksi
      true, // Isi Sisa Gas
      true, // Selesai Produksi
      false, // Spray (disable default)
      false, // Control Produksi (disable default)
    ];

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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Pilih Aksi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Daftar tombol
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: buttonStates.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final labels = [
                        'Filing',
                        'Refilling',
                        'Empty',
                        'Start Produksi',
                        'Isi Sisa Gas',
                        'Selesai Produksi',
                        'Spray',
                        'Control Produksi'
                      ];
                      return ElevatedButton(
                        onPressed: buttonStates[index]
                            ? () {
                                // Logika tombol
                                _handleButtonClick(
                                    index, buttonStates, setModalState);
                              }
                            : null, // Disable tombol jika false
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonStates[index]
                              ? Colors.blue.shade900
                              : Colors.grey.shade400,
                        ),
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            color: buttonStates[index]
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // Tombol untuk menutup modal
                  ListTile(
                    title:
                        const Center(child: Text('Selesai Produksi Di Klik')),
                    subtitle: GroupButton(
                      isRadio: true, // Agar bisa memilih lebih dari satu
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                        buttonHeight: 40,
                        buttonWidth: 120,
                        mainGroupAlignment: MainGroupAlignment.center,
                        crossGroupAlignment: CrossGroupAlignment.start,
                        groupRunAlignment: GroupRunAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                      ),
                      onSelected: (value, index, isSelected) {
                        if (index == 0) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      buttons: const [
                        'Lanjut Produksi',
                        'Off Compressor',
                      ],
                    ),
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'C2H2',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
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
            const Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemCount: 20, // jumlah data dummy
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      _showCustomModal(context, width, height);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('D57211', style: titleText),
                  );
                },
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
            title: 'Submit',
            onpressed: () async {
              _showCustomModal(context, width, height);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
