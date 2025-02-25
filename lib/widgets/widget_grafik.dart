import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';

class WidgetGrafik extends StatelessWidget {
  final double percentage; // Persentase yang ingin ditampilkan (0 - 100)
  final String text; // Teks yang akan ditampilkan di dalam container
  final double width; // Lebar dari container
  final double height; // Tinggi dari container

  // Constructor untuk widget
  WidgetGrafik({
    required this.percentage,
    required this.text,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Layer background putih
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black),
          ),
        ),
        // Layer background biru berdasarkan persentase
        Container(
          width: width * (percentage / 100), // Lebar berubah sesuai persentase
          height: height,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        // Teks di atas kedua layer
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(text, style: subtitleText),
            ),
          ),
        ),
      ],
    );
  }
}
