import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({
    super.key,
    required this.HB,
    required this.FW,
    required this.icon,
    required this.isi,
    required this.navigator,
  });

  final double HB;
  final double FW;
  final Image icon;
  final String isi;
  final VoidCallback navigator;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigator,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: FW * 0.01, vertical: HB * 0.005),
        padding:
            EdgeInsets.symmetric(vertical: HB * 0.025, horizontal: FW * 0.03),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: icon,
              ),
            ),
            SizedBox(
              height: HB * 0.01,
            ),
            SizedBox(
              width: FW,
              height: 25,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(isi, style: titleTextBlack)),
            )
          ],
        ),
      ),
    );
  }
}
