import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unicode_test/core/theme/colors.dart';

class Utils {
  ///* Hide keyboard
  static hideKeyboard() {
    FocusManager focus = FocusManager.instance;
    if (focus.primaryFocus?.hasFocus ?? false) {
      focus.primaryFocus?.unfocus();
    }
  }

  static Color getColorFromString(String hexColor) {
    // Remove the # character if it's present
    hexColor = hexColor.replaceAll('#', '');

    // Parse the hex color code as an integer
    int hexValue = int.parse(hexColor, radix: 16);

    // Create a Color object from the parsed integer
    return Color(hexValue | 0xFF000000); // Adding 0xFF for opacity (fully opaque)
  }

  static ColorFilter colorFilter({required Color color}) {
    return ColorFilter.mode(
      color,
      BlendMode.srcIn,
    );
  }

  static bool isSameDay({required DateTime firstDate, required DateTime secondDate}) {
    return firstDate.day == secondDate.day && firstDate.month == secondDate.month && firstDate.year == secondDate.year;
  }

  static Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 20),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsPalletes.mainColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
  }
}

logMe(dynamic data) {
  if (kDebugMode) {
    log(data.toString(), time: DateTime.now());
  }
}
