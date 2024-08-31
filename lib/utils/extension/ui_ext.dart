import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiver/strings.dart' as qu;

extension UIExtension on num {
  ///* Return [BorderRadius] for widget
  BorderRadius get br => BorderRadius.circular(toDouble());

  ///* Padding `EdgeInsets.all(this)`
  EdgeInsets get paddingAll => EdgeInsets.all(r);

  ///* Padding `EdgeInsets.all(this)`
  EdgeInsets get paddingTop => EdgeInsets.only(top: r);
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: r);

  ///* Return [Radius] for widget
  Radius get rBr => Radius.circular(toDouble());

  ///* Substract date
  DateTime get pDate => DateTime.now().subtract(Duration(days: toInt()));

  ///* Substract date
  DateTime get fDate => DateTime.now().add(Duration(days: toInt()));

  Duration get seconds => Duration(seconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());

  // ///* Get uid from specific digit `5.uuid``
  // String get uuid => Utils.getUID.substring(0, toInt());

  ///* From seconds to milliseconds
  Duration get secToMilliSec => Duration(milliseconds: (this * 1000).toInt());
}

extension TextExt on String {
  int get toInt => int.tryParse(this) ?? 0;
  int get versionToInt {
    String version = replaceAll('.', '');
    return version.toInt;
  }

  String get formatToNum => num.parse(this).formatted.toString();

  bool get isLocalFile => !contains('http');

  ///* Same
  bool same(String data) => this == data;

  String get getArabicDigit {
    return replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }

  String get removeDiacritics {
    final mapDiacritics = {
      'ٌ': '',
      'ٍ': '',
      'ً': '',
      'ُ': '',
      'ِ': '',
      'َ': '',
      'ّ': '',
      'ْ': '',
      // Additional variations for some letters
      'أ': 'ا', // Alef with Hamza Above
      'إ': 'ا', // Alef with Hamza Below
      'آ': 'ا', // Alef with Madda Above
    };

    for (var key in mapDiacritics.keys) {
      replaceAll(key, mapDiacritics[key]!);
    }
    return this;
  }

  bool get isArabicString {
    final arabicRegex = RegExp(r'^[ء-ي ]+$');
    return arabicRegex.hasMatch(this);
  }

  bool isEqualTo(String? value) => this == value;
  bool isNotEqualTo(String? value) => this != value;
}

extension TextExtention on TextEditingController {
  ///* Return `String` after trim text from controller
  String get trimText => text.trim();

  ///* Return `int` from controller text
  int toInt() => int.tryParse(text) ?? 0;

  ///* Return `double` from controller text
  double toDouble() => double.tryParse(text) ?? 0;

  bool get isNotEmpty => trimText.isNotEmpty;
  bool get isEmpty => trimText.isEmpty;

  ///* Return `bool` if searching
  bool get isSearching => text.isNotEmpty;
}

extension NumberDigit on num {
  ///* Get value like `50.90999 to 50.90` or `50.00 to 50`
  num get formatted {
    if (this % 1 == 0) {
      return toInt();
    } else {
      return double.parse(toStringAsFixed(2));
    }
  }

  ///* Get value like `50.90999 to 50.9` or `50.00 to 50`
  num get formatted1Fixed {
    if (this % 1 == 0) {
      return toInt();
    } else {
      return double.parse(toStringAsFixed(1));
    }
  }

  ///* Num to string
  String get string {
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toStringAsFixed(2);
    }
  }
}

extension DoubleFormat on double {
  ///* Num to string
  String get doubleFormatted {
    debugPrint('this:$this');
    if (this % 1 == 0 || this % 1 < .05) {
      return toInt().toString();
    } else {
      return toStringAsFixed(1);
    }
  }
}

extension IterableExtension<T> on Iterable<T> {
  List<T> removeDuplicates<U>({required U Function(T t) by}) {
    final unique = <U, T>{};

    for (final item in this) {
      unique.putIfAbsent(by(item), () => item);
    }

    return unique.values.toList();
  }
}

// extrntion for Locale isArabic
extension LocaleExt on Locale {
  bool get isArabic => languageCode == 'ar';
  bool get isEnglish => languageCode == 'en';
}

extension DurationFormatting on Duration {
  String formatAsHoursMinutesAndSeconds() {
    int hours = inHours;
    int minutes = inMinutes % 60;
    int seconds = inSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hoursStr:$minutesStr:$secondsStr';
    } else {
      return '$minutesStr:$secondsStr';
    }
  }
}

extension Quiver on String? {
  bool get isBlank => qu.isBlank(this);
  bool get isNotBlank => qu.isNotBlank(this);
  bool equalToIgnoreCase(String? str) => qu.equalsIgnoreCase(this, str);
}
