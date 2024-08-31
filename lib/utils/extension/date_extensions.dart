import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:unicode_test/core/theme/localization.dart';
import 'package:unicode_test/utils/utils.dart';

// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// import "package:timeago/timeago.dart" as time_ago;

extension DateExtension on DateTime {
  static final DateTime today = DateTime.now();
  static Locale locale = LocalizationsData.englishLocale;

  String get formatted => DateFormat('d/M/y h:mm:ss a', 'en_US').format(toLocal());

  ///* Return ```true``` if provided date is today
  bool get isToday => today.day == day && today.month == month && today.year == year;

  bool get isInCurrentWeek => today.difference(this).inDays < 7;

  int get age => today.difference(this).inDays ~/ 365;

  int get daysLeft => difference(today).inDays;

  DateTime get dayBefore => subtract(const Duration(days: 1));

  DateTime get dayAfter => add(const Duration(days: 1));

  ///* Days left from today
  int get daysLeftFromToday => daysLeft.isNegative ? 0 : daysLeft;

  ///* Return ```true``` if provided date is in same month of the today
  bool get isSubExpired => today.compareTo(this) == 1;

  ///* Check difference between 2 dates
  int get daysDifference => today.difference(this).inDays;

  ///* Check difference between 2 dates
  int daysDifferenceInDates(DateTime date, {bool ignoreTime = false}) {
    var firstDate = ignoreTime ? DateTime(year, month, day) : this;
    var secondDate = ignoreTime ? DateTime(date.year, date.month, date.day) : date;
    int days = firstDate.difference(secondDate).inDays;
    logMe('Days difference ${date.dmyFormat} == $dmyFormat ---> $days');
    return days;
  }

  ///* Return Day Name From Date [Saturday]
  String get dayName => DateFormat('EEEE', locale.languageCode).format(this);

  ///* Return Day Name From Date [Saturday]
  String get dayShortName => DateFormat('EEE', locale.languageCode).format(this).toUpperCase();

  int get weekDayIndex => weekday - 1;

  ///* Return Formatted time as `String` [12:05 PM]
  String get timeFormat => DateFormat.jm(locale.languageCode).format(this);

  ///* Return Formatted time as `String` [12:05]
  String get hourAndMuintes => DateFormat('hh:mm').format(this);

  ///* Return Formatted time as `String` [25 July]
  String get dateMonthFormat => DateFormat.MMMMd(locale.languageCode).format(this);

  ///* Return Formatted Day, Month, Year name as `String` [Sunday, 19 July 2022]
  String get dayMonthYearFormat => DateFormat.yMMMEd(locale.languageCode).format(this);

  ///* Return Formatted Day, Month, Year name as `String` [Sunday, 19 July]
  String get dayMonthFormat => DateFormat.yMMMd(locale.languageCode).format(this);

  // ///* Return Formatted Time ago [1 minute ago]
  // String get timeAgoFormat =>
  //     time_ago.format(this, locale: locale.languageCode);

  ///* Return Formatted Day, Month, Year name as `String` [19 July 2022]
  String get dateDayMonthYearFormat => DateFormat.yMMMd(locale.languageCode).format(this);

  ///* Return Formatted Day, Month, Year name as `String` [July 2022]
  String get dateMonthYearFormat => DateFormat.yMMM(locale.languageCode).format(this);

  ///* Return Formatted time as `String` [25 Jul]
  String get dateMonthShortFormat => DateFormat.MMMd(locale.languageCode).format(this);

  ///* Return Formatted Day, Month, Year name as `String` [12:00 PM, 19 July 2022]
  String get fullDateTimeFormat => DateFormat(null, locale.languageCode).add_MMMEd().add_jm().format(this);

  ///* Return Formatted Month, Year name as `String` [12-2023]
  String get graphDateFormat => DateFormat('MM-y').format(this);

  ///* Return Formatted Month, Year name as `String` [2023-12]
  String get analysisDateFormat => DateFormat('y-MM').format(this);

  ///* Return Formatted Month, Year name as `String` [2023-12]
  String get reportDateFormat => DateFormat('yy-MM').format(this);

  ///* Return Formatted Month, Year name as `String` [10-12-2023]
  String get dmyFormat => DateFormat('y-MM-dd').format(this);

  ///* Return Formatted Month, Year name as `String` [10-12-2023]
  String get ymdFormat => DateFormat('dd-MM-y').format(this);

  ///* Return Formatted day.month.year as `String` [25.05.2024]
  String get dmyDotsFormat => DateFormat('dd.MM.y').format(this);

  ///* Return Formatted Month, Year name as `String` [12/02/2023]
  String get dmySlashFormat => DateFormat('dd/MM/y').format(this);

  ///* Return Formatted Day as `String` [saturday]
  String get weekDayName => DateFormat('EEEE', locale.languageCode).format(this);

  ///* Return Formatted Month, Year name as `String` [12]
  String get monthDay => DateFormat('dd').format(this);

  ///* Return Formatted time as `String` [25/10]
  String get dayMonthSlashFormat => DateFormat('dd/MM').format(this);

  ///* Return Formatted Date as `String` [Jun 25]
  String get shortMonthDayFormat => DateFormat('MMM dd').format(this).toUpperCase();
}
