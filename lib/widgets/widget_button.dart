import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetButton extends StatelessWidget {
  WidgetButton(
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
  WidgetStateProperty<double?>? elevation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OutlinedButton(
      style: ButtonStyle(
        side: WidgetStatePropertyAll(BorderSide(color: color)),
        backgroundColor: WidgetStatePropertyAll(
            (bgColor == null) ? Colors.transparent : bgColor),
        elevation:
            (elevation != null) ? elevation : const WidgetStatePropertyAll(5),
        shadowColor: WidgetStatePropertyAll(
            (shadowColor != null) ? shadowColor : Colors.transparent),
        minimumSize: WidgetStatePropertyAll(Size(FullWidth, FullHeight)),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: FullWidth * 0.3, vertical: 0),
        ),
      ),
      onPressed: () {
        onpressed();
      },
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'Manrope',
              color: (titleColor != null) ? titleColor : Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
