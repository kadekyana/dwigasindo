import 'package:flutter/material.dart';

class BodyCard extends StatelessWidget {
  final String kodePermintaan;
  final String divisi;
  final String kategori;

  const BodyCard({
    super.key,
    required this.kodePermintaan,
    required this.divisi,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text('Kode Permintaan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: Text(': $kodePermintaan'),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 2,
              child:
                  Text('Divisi', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: Text(': $divisi', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text('Kategori',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: Text(': $kategori'),
            ),
          ],
        ),
      ],
    );
  }
}
