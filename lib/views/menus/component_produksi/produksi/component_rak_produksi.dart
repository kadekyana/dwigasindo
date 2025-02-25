import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi/component_detail_rak.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ComponentRakProduksi extends StatelessWidget {
  const ComponentRakProduksi({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Rak Produksi',
        back: true,
        route: () {
          Navigator.pop(context);
        },
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            GroupButton(
                maxSelected: 15,
                isRadio: false,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  unselectedBorderColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                },
                buttons: const [
                  'Rak 1',
                  "Rak 2",
                  "Rak 3",
                  "Rak 4",
                  "Rak 5",
                  "Rak 6",
                  "Rak 7",
                  "Rak 8",
                  "Rak 9",
                  "Rak 10",
                  "Rak 11"
                ]),
            SizedBox(
              height: height * 0.02,
            ),
            WidgetButtonCustom(
                FullWidth: width * 0.93,
                FullHeight: height * 0.06,
                title: 'Submit',
                onpressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ComponentDetailRak(),
                    ),
                  );
                },
                bgColor: PRIMARY_COLOR,
                color: PRIMARY_COLOR),
          ],
        ),
      ),
    );
  }
}
