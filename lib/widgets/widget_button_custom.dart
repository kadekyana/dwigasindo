import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetButtonCustom extends StatelessWidget {
  WidgetButtonCustom(
      {super.key,
      required this.FullWidth,
      required this.FullHeight,
      required this.title,
      required this.onpressed,
      this.titleColor,
      this.bgColor,
      this.shadowColor,
      this.elevation,
      required this.color});
  final double FullWidth;
  final double FullHeight;
  final String title;
  final Function onpressed;
  final Color color;
  Color? titleColor;
  Color? bgColor;
  Color? shadowColor;
  MaterialStateProperty<double?>? elevation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        width: FullWidth,
        height: FullHeight,
        padding: EdgeInsets.symmetric(
            horizontal: FullWidth * 0.25, vertical: FullHeight * 0.15),
        decoration: BoxDecoration(
          color: (bgColor == null) ? Colors.transparent : bgColor,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Manrope',
                color: (titleColor != null) ? titleColor : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
