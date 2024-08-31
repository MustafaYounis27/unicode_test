import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';

Future<T?> unifiedBottomSheet<T>(BuildContext context, Widget child, {double? maxHeight, String? title}) async {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      maxHeight: maxHeight ?? 0.8.sh,
      minWidth: double.infinity,
      minHeight: 0.3.sh,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(.045.sw))),
    builder: (context) {
      return Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            if (title != null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyles.medium_16.copyWith(color: ColorsPalletes.secondry900),
                    ),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: ColorsPalletes.text800))
                ],
              ),
              SizedBox(height: 0.01.sh),
            ],
            Expanded(child: child),
          ],
        ),
      );
    },
  );
}
