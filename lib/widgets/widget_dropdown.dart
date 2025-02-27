import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final SingleSelectController<String?>? controller;
  String? datValue;
  final dynamic Function(String?)? onChanged;

  WidgetDropdown(
      {super.key,
      required this.items,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      this.datValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Consumer<ProviderDistribusi>(
          builder: (context, provider, child) {
            return CustomDropdown(
              controller: controller,
              decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: Colors.grey.shade400),
                  expandedBorder: Border.all(color: Colors.grey.shade400)),
              hintText: hintText,
              items: items,
              onChanged: onChanged,
              // (value) {
              //   if (datValue != null) {
              //     provider.setSelectedItem(datValue!);
              //     print(datValue);
              //   } else if (value != null && datValue == null) {
              //     provider.setSelectedItem(value);
              //     print(value);
              //   }
              // },
            );
          },
        ),
      ],
    );
  }
}
