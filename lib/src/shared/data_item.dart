import 'package:flutter/material.dart';
import 'package:health_center_core/health_center_core.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    required this.label,
    required this.value,
    this.padding,
  });

  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(
                  color: HealthCenterTheme.blueColor,
                  fontWeight: FontWeight.w500)),
          Text(
            value,
            style: const TextStyle(
                color: HealthCenterTheme.orangeColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
