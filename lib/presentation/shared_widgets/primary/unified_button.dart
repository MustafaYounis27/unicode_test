import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/presentation/shared_widgets/loading_indicator.dart';

class UnifiedButton extends StatelessWidget {
  const UnifiedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color = ColorsPalletes.mainColor,
    this.borderColor = ColorsPalletes.mainColor,
    this.textColor,
    this.isFullWidth = false,
    this.width,
    this.loading = false,
    this.disabled = false,
    this.isRounded = false,
    this.isOutlined = false,
    this.radius,
    this.height,
    this.elevation = 0,
    this.textStyle,
  });

  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final void Function() onPressed;
  final String title;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final bool loading;
  final bool disabled;
  final bool isRounded;
  final bool isOutlined;
  final double? radius;
  final double? elevation;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? 0.065.sh,
      child: _parentWidget(
        !loading
            ? Text(
                title,
                style: textStyle ?? TextStyles.bold_16.copyWith(color: textColor ?? (disabled ? ColorsPalletes.secondry500 : Colors.white)),
                textAlign: TextAlign.center,
              ).tr()
            : const LoadingIndicator(color: ColorsPalletes.primaryBlack),
        buttonStyle,
      ),
    );
  }

  ButtonStyle? get buttonStyle {
    if (isOutlined) {
      return OutlinedButton.styleFrom(
        elevation: elevation,
        side: BorderSide(color: borderColor ?? Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isRounded ? 1000.r : radius ?? 10.r)),
        disabledBackgroundColor: ColorsPalletes.secondry50,
      );
    }
    return ElevatedButton.styleFrom(
      elevation: elevation,
      backgroundColor: color,
      foregroundColor: borderColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isRounded ? 1000.r : radius ?? 10.r)),
      disabledBackgroundColor: ColorsPalletes.secondry50,
    );
  }

  Widget _parentWidget(Widget child, ButtonStyle? style) {
    if (isOutlined) return OutlinedButton(onPressed: disabled || loading ? null : onPressed, style: style, child: child);
    return ElevatedButton(onPressed: disabled || loading ? null : onPressed, style: style, child: child);
  }
}
