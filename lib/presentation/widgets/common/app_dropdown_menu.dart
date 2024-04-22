import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppDropdownMenu extends StatelessWidget {
  final String label;
  final List<String> menuItems;
  final String selectedItem;
  final Function(String?) onItemSelected;

  const AppDropdownMenu({
    super.key,
    required this.label,
    required this.menuItems,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = AppAdaptiveSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.widthInPixels(40),
          child: Text(label,
          overflow: TextOverflow.clip,
          maxLines: 1,
              style: TextStyle(
                  fontSize: size.widthInPixels(14),
                  fontWeight: FontWeight.bold)),
        ),
        DropdownButton<String>(
          value: selectedItem,
          onChanged: (String? newValue) {
            onItemSelected(newValue);
          },
          items: menuItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
