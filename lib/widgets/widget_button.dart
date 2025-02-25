import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  MaterialStateProperty<double?>? elevation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(color: color)),
        backgroundColor: MaterialStatePropertyAll(
            (bgColor == null) ? Colors.transparent : bgColor),
        elevation:
            (elevation != null) ? elevation : const MaterialStatePropertyAll(5),
        shadowColor: MaterialStatePropertyAll(
            (shadowColor != null) ? shadowColor : Colors.transparent),
        minimumSize: MaterialStatePropertyAll(Size(FullWidth, FullHeight)),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: FullWidth * 0.3, vertical: 0),
        ),
      ),
      onPressed: () {
        onpressed();
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12.sp,
              color: (titleColor != null) ? titleColor : Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
