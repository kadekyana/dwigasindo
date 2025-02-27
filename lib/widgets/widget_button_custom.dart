import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetButtonCustom extends StatelessWidget {
  WidgetButtonCustom(
      {super.key,
      required this.FullWidth,
      required this.FullHeight,
      required this.title,
      this.onpressed,
      this.titleColor,
      this.bgColor,
      this.shadowColor,
      this.elevation,
      required this.color});
  final double FullWidth;
  final double FullHeight;
  final String title;
  Function? onpressed;
  final Color color;
  TextStyle? titleColor;
  Color? bgColor;
  Color? shadowColor;
  WidgetStateProperty<double?>? elevation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed!();
      },
      child: Container(
        width: FullWidth,
        height: FullHeight,
        padding: EdgeInsets.only(
            left: FullWidth * 0.05,
            right: FullWidth * 0.05,
            bottom: FullHeight * 0.05),
        decoration: BoxDecoration(
          color: (bgColor == null) ? Colors.transparent : bgColor,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title,
              style: (titleColor != null) ? subtitleTextBlack : subtitleText),
        ),
      ),
    );
  }
}
