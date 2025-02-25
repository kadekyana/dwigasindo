import 'package:flutter/material.dart';

class FooterCard extends StatelessWidget {
  final String createdBy;
  final VoidCallback onViewItems;

  const FooterCard({
    super.key,
    required this.createdBy,
    required this.onViewItems,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Created by $createdBy',
          style:
              const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        ElevatedButton(
          onPressed: onViewItems,
          child: const Text('Lihat Barang'),
        ),
      ],
    );
  }
}
