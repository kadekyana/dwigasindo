// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

// class MultiDropdownWidget<T> extends StatelessWidget {
//   final List<DropdownItem<T>> items;
//   final MultiSelectController<T> controller;
//   final String hintText;
//   final IconData prefixIcon;
//   final ValueChanged<List<T>>? onSelectionChange;
//   final bool enabled;
//   final bool searchEnabled;
//   final String Function(List<T>?)? validator;

//   const MultiDropdownWidget({
//     Key? key,
//     required this.items,
//     required this.controller,
//     this.hintText = 'Select an item',
//     this.prefixIcon = CupertinoIcons.flag,
//     this.onSelectionChange,
//     this.enabled = true,
//     this.searchEnabled = true,
//     this.validator,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiDropdown<T>(
//       items: items,
//       controller: controller,
//       enabled: enabled,
//       searchEnabled: searchEnabled,
//       chipDecoration: const ChipDecoration(
//         backgroundColor: Colors.yellow,
//         wrap: true,
//         runSpacing: 2,
//         spacing: 10,
//       ),
//       fieldDecoration: FieldDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.black87),
//         prefixIcon: Icon(prefixIcon),
//         showClearIcon: false,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.black87),
//         ),
//       ),
//       dropdownDecoration: const DropdownDecoration(
//         marginTop: 2,
//         maxHeight: 500,
//         header: Padding(
//           padding: EdgeInsets.all(8),
//           child: Text(
//             'Select items from the list',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       dropdownItemDecoration: DropdownItemDecoration(
//         selectedIcon: const Icon(Icons.check_box, color: Colors.green),
//         disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
//       ),
//       onSelectionChange: onSelectionChange,
//     );
//   }
// }
