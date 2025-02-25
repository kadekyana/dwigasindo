import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_bpti.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_bptk.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_tabung.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDistribusi extends StatelessWidget {
  const MenuDistribusi({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Distribusi',
        colorBack: Colors.black,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorTitle: Colors.black,
        colorBG: Colors.grey.shade100,
      ),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: CardUpDistribusi(),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    WidgetButtonDistribusi(
                      title: 'Bukti Penerimaan Tabung',
                      dataList: provider.dataBPTK1,
                      onItemTap: (context, data) async {
                        Navigator.pop(context);
                        print(
                          data['tipe'],
                        );
                        if (data['tipe'] == "BPTK") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ComponentBPTK(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ComponentBPTI(),
                            ),
                          );
                          final provider = Provider.of<ProviderDistribusi>(
                              context,
                              listen: false);
                          await provider.getAllBPTI(context);
                        }
                      },
                    ),
                    const WidgetButtonDistribusi(
                      title: 'Surat Jalan',
                      dataList: null,
                      onTap: ComponentSuratJalan(),
                    ),
                    WidgetButtonDistribusi(
                      title: 'Tabung',
                      dataList: provider.Tabung,
                      onItemTap: (context, data) async {
                        await provider.countClear();
                        provider.isLoadingTube = true;
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComponentTabung(),
                          ),
                        );
                        await provider.getAllTube(context);
                        await provider.countTube();
                        await provider.getAllTubeGrade(context);
                        await provider.getAllTubeType(context);
                        await provider.getAllTubeGas(context);
                        await provider.getAllCostumer(context);
                        await provider.getAllSupplier(context);
                        provider.isLoadingTube = false;
                      },
                    ),
                    WidgetButtonDistribusi(
                      title: 'Claim',
                      dataList: provider.dataBPTK1,
                      onItemTap: (context, data) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComponentBPTK(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardUpDistribusi extends StatelessWidget {
  const CardUpDistribusi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: double.maxFinite,
            height: 26,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ringkasan",
                style: titleText,
              ),
            ),
          ),
          const Divider(),
          // Row Pertama
          Expanded(
            child: Container(
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "BPTK",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Bulan ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "BPTI",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Bulan ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Row Kedua
          Expanded(
            child: Container(
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "Surat Jalan",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Hari ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Bulan ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "Claim",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Bulan ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                            child: Text(
                              "Bulan ini",
                              style: titleText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              "10.000",
                              style: titleText,
                            ),
                          ),
                        )
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
  }
}
