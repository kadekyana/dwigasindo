import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;

  const HeaderCard({
    super.key,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text(date, style: subtitleText),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Text(status, style: subtitleText),
          ),
        ],
      ),
    );
  }
}
