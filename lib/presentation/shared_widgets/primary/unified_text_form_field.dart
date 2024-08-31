// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unicode_test/core/constants/image_constants.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

class UnifiedTextFormField extends StatefulWidget {
  final bool isIp;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final IconData? icon;
  final bool showError;
  final bool autoFocus;
  final bool isPassword;
  final String? hintText;
  final Color? mainColor;
  final Color? textColor;
  final String? labelText;
  final bool isPredefined;
  final Color accentColor;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final FocusNode focusNode;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final void Function()? onTap;
  final TextInputType? inputType;
  final double topCircularRadius;
  final double bottomCircularRadius;
  final void Function()? suffixPressed;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showKeyboard;
  final String? initialValue;
  final TextStyle? style;
  final bool disable;
  final bool autoOpenKeyboard;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool ignoreAutoValidator;
  final Color? suffixIconColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final bool hasDivider;
  final String? title;

  UnifiedTextFormField({
    super.key,
    this.icon,
    this.onTap,
    this.hintText,
    this.onChange,
    this.onSubmit,
    this.inputType,
    this.labelText,
    this.validator,
    this.mainColor,
    this.textColor,
    this.helperText,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.isIp = false,
    this.maxLines = 1,
    this.suffixPressed,
    this.backgroundColor,
    this.textInputAction,
    this.maxLength,
    this.readOnly = false,
    this.showError = false,
    this.autoFocus = false,
    this.isPassword = false,
    required this.controller,
    this.isPredefined = true,
    this.topCircularRadius = 5,
    this.bottomCircularRadius = 5,
    Color? accentColor,
    this.initialValue,
    this.style,
    this.disable = false,
    this.autoOpenKeyboard = true,
    bool showKeyboard = true,
    FocusNode? focusNode,
    this.floatingLabelBehavior,
    this.ignoreAutoValidator = false,
    this.suffixIconColor,
    this.hintTextStyle,
    this.labelStyle,
    this.hasDivider = false,
    this.title,
  })  : focusNode = focusNode ?? FocusNode(),
        showKeyboard = readOnly ? false : showKeyboard,
        accentColor = accentColor ?? ColorsPalletes.grey300;

  @override
  State<UnifiedTextFormField> createState() => _UnifiedTextFormFieldState();
}

class _UnifiedTextFormFieldState extends State<UnifiedTextFormField> {
  InputBorder get inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: ColorsPalletes.grey300, style: BorderStyle.solid),
      );

  InputBorder get focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: ColorsPalletes.secondry600, style: BorderStyle.solid),
      );

  InputBorder get errorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: ColorsPalletes.primary800, style: BorderStyle.solid),
      );

  bool get hasPrefixIcon {
    if (widget.prefixWidget != null) return true;
    if (widget.prefixIcon != null) return true;
    return false;
  }

  Widget? get suffixWidget => widget.isPassword || widget.suffixIcon != null
      ? IconButton(
          onPressed: !widget.showError
              ? (!widget.isPassword
                  ? widget.suffixPressed
                  : () => setState(() {
                        changePasswordVisibility();
                      }))
              : null,
          icon:
              Icon(widget.showError ? Icons.error : (widget.isPassword ? passwordIcon : widget.suffixIcon), color: widget.suffixIconColor),
        )
      : null;

  bool obscure = false;
  IconData? passwordIcon;
  Color defaultFillColor = Colors.grey.shade200;
  late Widget suffixIcon;

  @override
  void initState() {
    obscure = widget.isPassword;
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }

    passwordIcon = widget.isPassword ? Icons.visibility : null;
    super.initState();
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
                if (!widget.ignoreAutoValidator || widget.validator != null) ...[
                  TextSpan(text: '*', style: TextStyles.medium_14.copyWith(color: ColorsPalletes.primary800)),
                ],
              ],
            ),
          ),
          SizedBox(height: 0.02.sh),
        ],
        TextFormField(
          enabled: !widget.disable,
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          obscureText: obscure,
          cursorColor: widget.textColor,
          style: widget.style ?? TextStyle(color: widget.textColor ?? Theme.of(context).textTheme.bodySmall?.color ?? Colors.black),
          keyboardType: widget.inputType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            contentPadding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
            hintText: widget.hintText?.tr(),
            icon: widget.icon != null ? Icon(widget.icon) : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintStyle: TextStyles.regular_14.copyWith(color: ColorsPalletes.grey500),
            prefixIcon: hasPrefixIcon
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 20.r),
                      widget.prefixWidget ??
                          (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.grey.shade500) : const SizedBox()),
                      if (widget.hasDivider) ...[
                        SizedBox(width: 10.r),
                      ],
                    ],
                  )
                : widget.inputType == TextInputType.phone
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 20.r),
                          SvgPicture.asset(ImageConstants.egyFlag, height: 20.r, width: 20.r),
                          SizedBox(width: 5.r),
                          Text('+966', style: TextStyles.medium_14.copyWith(color: ColorsPalletes.brown)),
                          SizedBox(width: 10.r),
                        ],
                      )
                    : null,
            suffixIcon: widget.suffixWidget != null || suffixWidget != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.suffixWidget != null) ...[
                        widget.suffixWidget!,
                      ] else if (suffixWidget != null) ...[
                        suffixWidget!,
                      ],
                    ],
                  )
                : null,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            enabledBorder: inputBorder,
            border: inputBorder,
            counterText: '',
            helperText: widget.helperText,
            helperMaxLines: 2,
          ),
          onChanged: widget.onChange,
          validator: widget.validator ?? (widget.ignoreAutoValidator ? null : (value) => handleValidation(value)),
          onFieldSubmitted: widget.onSubmit,
          onTap: widget.onTap,
        ),
      ],
    );
  }

  String? getLabelText() {
    if (widget.floatingLabelBehavior == FloatingLabelBehavior.never) return null;

    return widget.labelText?.tr();
  }

  void changePasswordVisibility() {
    obscure = !obscure;
    if (obscure) {
      passwordIcon = Icons.visibility;
    } else {
      passwordIcon = Icons.visibility_off;
    }
  }

  String? handleValidation(String? value) {
    if (widget.inputType == TextInputType.emailAddress) {
      return Validation.emailValidation(value);
    }

    if (widget.inputType == TextInputType.phone) {
      return Validation.mobileValidation(value);
    }

    if (widget.inputType == TextInputType.name) {
      return Validation.nameValidation(value);
    }

    if (value.isBlank) return 'Field is required';
    return null;
  }
}

class Validation {
  static String? notEmptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? mobileValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'The number not valid, please check again';
    } else {
      return RegExp(r'^\(?[+]?([0-9]{1,3})?\)? ?[0-9]{3,20}$').hasMatch(value) ? null : 'L10nKeys.invalidPhoneNum.Tr';
    }
  }

  static String? nameValidation(String? value) {
    if (value.isBlank) {
      return 'Field is required';
    }
    // if (value.length < 2) {
    //   return L10nKeys.nameNoCorrect;
    // }
    return null;
  }

  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    } else {
      return RegExp(
                  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)
          ? null
          : 'not type of Email';
    }
  }

  static String? numberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    } else {
      return RegExp(r'^[0-9]+$').hasMatch(value) ? null : 'should be numbers';
    }
  }
}
