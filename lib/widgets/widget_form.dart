import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetForm extends StatelessWidget {
  WidgetForm(
      {super.key,
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
      this.enable = false});

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontFamily: 'Poppins', color: color ?? Colors.black),
      controller: controller,
      obscureText: obscure,
      readOnly: enable,
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
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            color: (colorLabel != null) ? colorLabel : Colors.grey.shade400),
        focusedBorder: focborder,
        border: border,
        enabledBorder: endborder,
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: "Manrope",
            color: (colorHint != null) ? colorHint : Colors.grey.shade400),
        prefixIcon: preicon,
        suffixIcon: suicon,
        isDense: true, // Mengurangi padding
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}
