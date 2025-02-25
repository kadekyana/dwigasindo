import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class WidgetForm extends StatelessWidget {
  WidgetForm(
      {Key? key,
      required this.alert,
      required this.hint,
      this.preicon,
      this.suicon,
      this.obscure = false,
      this.controller,
      this.onSubmit,
      this.border,
      this.focborder,
      this.endborder,
      this.color,
      this.label,
      this.colorLabel,
      this.colorHint,
      this.typeInput,
      this.initV,
      this.change,
      this.enable = true})
      : super(key: key);

  final String alert;
  final String hint;
  Widget? preicon;
  final Widget? suicon;
  final bool obscure;
  final TextEditingController? controller;
  final VoidCallback? onSubmit;
  bool enable;
  Color? color;
  InputBorder? border;
  InputBorder? focborder;
  InputBorder? endborder;
  String? label;
  String? initV;
  Color? colorLabel;
  Color? colorHint;
  TextInputType? typeInput;
  Function(String)? change;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontFamily: 'Manrope', color: color ?? Colors.black),
      controller: controller,
      obscureText: obscure,
      readOnly: !enable, // Use enable to toggle read-only state
      keyboardType: typeInput,
      validator: (value) {
        if (value!.isEmpty) {
          return alert;
        }
        return null;
      },
      onFieldSubmitted: (_) {
        if (onSubmit != null) {
          onSubmit!();
        }
      },
      onChanged: change,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.sp,
            color: (colorLabel != null) ? colorLabel : Colors.grey.shade400),
        focusedBorder: focborder,
        border: border,
        enabledBorder: endborder,
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: "Manrope",
            fontSize: 14.sp,
            color: (colorHint != null) ? colorHint : Colors.grey.shade400),
        prefixIcon: preicon,
        suffixIcon: suicon,
        isDense: true, // Mengurangi padding
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        // If the field is disabled, change the hintText color
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
