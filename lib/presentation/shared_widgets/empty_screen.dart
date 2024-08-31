import 'package:flutter/material.dart';
import 'package:unicode_test/core/theme/styles.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final TextStyle? style;
  final Widget? emptyAsset;
  const EmptyScreen({super.key, required this.message, this.emptyAsset, this.style});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emptyAsset != null) emptyAsset!,
          Text(message, style: style ?? TextStyles.bold_14),
        ],
      ),
    );
  }
}
