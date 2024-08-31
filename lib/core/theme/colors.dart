import 'package:flutter/material.dart';

class ColorsPalletes {
  ColorsPalletes._();

  static const Color secondry50 = Color(0xFFF2EBF3);
  static const Color secondry100 = Color(0xFFE4D7E8);
  static const Color secondry500 = Color(0xFF78378B);
  static const Color secondry600 = Color(0xFFBB9BC5);
  static const Color secondry700 = Color(0xFF542761);
  static const Color secondry900 = Color(0xFF3C1C46);
  static const Color primary50 = Color(0xFFBFFEBE6);
  static const Color primary100 = Color(0xFFFFDCD2);
  static const Color primary500 = Color(0xFFED8E79);
  static const Color primary600 = Color(0xFFEE8F7A);
  static const Color primary800 = Color(0xFFB25946);
  static const Color primary900 = Color(0xFF5C271C);
  static const Color green50 = Color(0xFFE0F8F4);
  static const Color green500 = Color(0xFF59B8AB);
  static const Color green600 = Color(0xFF23A495);
  static const Color green900 = Color(0xFF123D37);
  static const Color yellow100 = Color(0xFFFDF5DD);
  static const Color yellow500 = Color(0xFFF8DF8D);
  static const Color brown = Color(0xFF2D2A26);
  static const Color brown100 = Color(0xFFD5D4D4);
  static const Color brown600 = Color(0xFF6C6A67);
  static const Color brown800 = Color(0xFF423F3C);
  static const Color text800 = Color(0xFF484E5D);
  static const Color grey300 = Color(0xFFE9EAEC);
  static const Color grey500 = Color(0xFFA0AEC0);
  static const Color shadow = Color(0xFF3C1C46);

  static const Color primaryBlack = Color(0xFF2D2A26);
  static const Color primaryGreen = Color(0xFF81C7BC);
  static const Color primaryMove2 = Color.fromARGB(255, 172, 68, 204);
  static const Color primaryOrange = Color(0xFFEE8F7A);
  static const Color primaryYellow = Color(0xFFF8DF8D);
  static const Color primaryBlue = Color(0xFF8BB7E2);
  static const Color primaryBlue2 = Color.fromARGB(255, 75, 131, 187);
  static const Color primaryLightGreen = Color(0xFF6A9F79);
  static const Color primaryLightGreenKids = Color(0xFFE5F5E7);
  static const Color primaryLightMove = Color(0xFF9382E7);

  static const Color mainColor = secondry500;
  static const Color linerGradient = Color(0xFF78378B00);

  static const Color primaryKidsGreen = Color(0xFF7ECA86);
  static const Color primaryKidsOrange = Color(0xFFFF845D);

  static const Color white = Color(0xffFFFFFF);
  static const Color transparent = Colors.transparent;

  static const Color red = Color(0xFFFF5353);
  static const Color lightRed = Color.fromARGB(255, 219, 102, 102);

  static const Color blue = Color(0xFF9382E7);
  static const Color blue1 = Color(0xFF34ABDF);
  static const Color blue2 = Color(0xFFCEEBFF);

  static const Color grey10 = Color(0xFFF7F7F7);
  static const Color grey20 = Color(0xFFF5F5F5);
  static const Color grey30 = Color(0xFFD6D6D6);
  static const Color grey40 = Color(0xFF999999);
  static const Color grey50 = Color(0xFF757575);
  static const Color grey60 = Color(0xFF666666);
  static const Color grey70 = Color(0xFFF0F5F1);
  static const Color grey80 = Color(0xFFF6F6F6);
  static const Color grey90 = Color(0xFFC5C4C4);
  static const Color grey100 = Color(0xFFEEEEEE);

  static const Color black10 = Color(0xFF333333);

  static const Color buttonColor1 = Color(0xFFF7F2ED);
  static const Color buttonColor2 = Color(0xFFF3EDE7);
  static const Color buttonColor3 = Color(0xFFebe0d4);
  static const Color buttonColor4 = Color(0xFFFFF5DC);

  static const Color orange = Color(0xFFFFA114);

  static const Color orange1 = Color(0xFFFFF5DC);

  static const Color purple = Color(0xFFDDC4FF);

  static const Color cyne = Color(0xFF34ABDF);
  static const Color lightCyne = Color(0xFFC7EAFF);
  static const Color lightCyne2 = Color(0xFFEAF7FC);
  static const Color lightCyne3 = Color(0xFFEEF8FF);
  static const Color gradient1 = Color(0xFFF7F2EC);

  static MaterialColor kPrimarySwatch = MaterialColor(
    ColorsPalletes.primaryGreen.value,
    <int, Color>{
      50: ColorsPalletes.primaryGreen.withOpacity(.1),
      100: ColorsPalletes.primaryGreen.withOpacity(.2),
      200: ColorsPalletes.primaryGreen.withOpacity(.3),
      300: ColorsPalletes.primaryGreen.withOpacity(.4),
      400: ColorsPalletes.primaryGreen.withOpacity(.5),
      500: ColorsPalletes.primaryGreen.withOpacity(.6),
      600: ColorsPalletes.primaryGreen.withOpacity(.7),
      700: ColorsPalletes.primaryGreen.withOpacity(.8),
      800: ColorsPalletes.primaryGreen.withOpacity(.9),
      900: ColorsPalletes.primaryGreen
    },
  );
}
