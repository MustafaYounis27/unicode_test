import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';

class UnifiedDropdownButton<T> extends StatefulWidget {
  final T? value;
  final bool outLined;
  final bool isDisabled;
  final Color? textColor;
  final String? hintText;
  final String? labelText;
  final Color accentColor;
  // [onTap] won't be excuted if [items] is empty
  final Function()? onTap;
  final bool showUnderline;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final InputBorder? customInputBorder;
  final Function(T v)? onChanged;
  final double topCircularRadius;
  final double bottomCircularRadius;
  final Iterable<UnifiedDropdownMenuItem<T>> items;
  final bool autoTranslate;
  final EdgeInsetsGeometry? contentPadding;
  final Function(T? v)? onChangedNullSupported;
  final TextStyle? style;
  final String? title;
  final bool isCenter;

  const UnifiedDropdownButton({
    super.key,
    this.onTap,
    this.value,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    required this.items,
    this.backgroundColor,
    this.outLined = false,
    this.onChanged,
    this.isDisabled = false,
    this.showUnderline = true,
    this.topCircularRadius = 0,
    this.bottomCircularRadius = 0,
    this.textColor,
    Color? accentColor,
    this.autoTranslate = true,
    this.contentPadding,
    this.customInputBorder,
    this.onChangedNullSupported,
    this.style,
    this.title,
    this.isCenter = false,
  }) : accentColor = accentColor ?? ColorsPalletes.primaryLightMove;

  @override
  State<UnifiedDropdownButton<T>> createState() => _UnifiedDropdownButtonState<T>();
}

class _UnifiedDropdownButtonState<T> extends State<UnifiedDropdownButton<T>> {
  late String hintText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hintText = widget.hintText ?? 'Select';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              text: '${widget.title} ',
              style: TextStyles.medium_14,
              children: [
                TextSpan(text: '*', style: TextStyles.medium_14.copyWith(color: ColorsPalletes.primary800)),
              ],
            ),
          ),
          SizedBox(height: 0.02.sh),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(widget.topCircularRadius),
              bottom: Radius.circular(widget.bottomCircularRadius),
            ),
          ),
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: widget.textColor ?? accentColor, size: 25) : null,
              suffixIcon: widget.suffixIcon,
              focusedBorder: focusBorder,
              enabledBorder: inputBorder,
              disabledBorder: inputBorder,
              border: inputBorder,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: hintText,
              contentPadding: widget.contentPadding,
            ),
            menuMaxHeight: 0.4.sh,
            style: widget.style,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorsPalletes.brown),
            alignment: widget.isCenter ? AlignmentDirectional.center : AlignmentDirectional.centerStart,
            value: widget.value,
            onTap: widget.onTap?.call(),
            isExpanded: true,
            iconDisabledColor: accentColor,
            iconEnabledColor: widget.textColor,
            items: widget.items
                .map((e) => DropdownMenuItem<T>(value: e.value, child: widget.autoTranslate ? Text(e.title) : Text(e.title)))
                .toList(),
            selectedItemBuilder: (context) => widget.items
                .map((e) => widget.autoTranslate
                    ? FittedBox(child: Text(e.title, style: hintStyle))
                    : FittedBox(child: Text(e.title, style: hintStyle)))
                .toList(),
            onChanged: widget.isDisabled
                ? null
                : (v) {
                    if (v != null && widget.onChanged != null) {
                      widget.onChanged!(v);
                    }
                    if (widget.onChangedNullSupported != null) {
                      widget.onChangedNullSupported!.call(v);
                    }
                  },
            validator: (v) {
              if (v == null) return 'Field is required';
              return null;
            },
          ),
        ),
      ],
    );
  }

  InputBorder get outLineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(width: 2, color: ColorsPalletes.grey300),
      );

  InputBorder get underLineBorder => widget.showUnderline
      ? UnderlineInputBorder(borderSide: BorderSide(color: accentColor, width: 1.5.r, style: BorderStyle.solid))
      : InputBorder.none;

  InputBorder get inputBorder => widget.customInputBorder != null ? widget.customInputBorder! : outLineInputBorder;

  InputBorder get focusBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(width: 2, color: ColorsPalletes.secondry600),
      );

  TextStyle get hintStyle => TextStyle(color: widget.textColor ?? accentColor, fontWeight: FontWeight.w500);

  Color get accentColor => ColorsPalletes.grey300;
}

class UnifiedDropdownMenuItem<T> {
  final T value;
  final String title;

  const UnifiedDropdownMenuItem({required this.value, required this.title});
}
