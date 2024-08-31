import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';
import '../../core/theme/colors.dart';

class Toasts {
  // ///* Show Toast
  static showToast({
    required String message,
    Color? bgColor,
    VoidCallback? onClose,
    Duration duration = const Duration(seconds: 2),
    Alignment? align,
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      onClose: onClose,
      backButtonBehavior: BackButtonBehavior.close,
      align: align ?? Alignment.topCenter,
      useSafeArea: false,
      toastBuilder: (_) {
        return Container(
            height: 90.r,
            width: 100.w,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 16.r, right: 15.r, left: 15.r),
            color: bgColor ?? ColorsPalletes.red.withOpacity(.9),
            child: Text(
              message,
              style: TextStyles.medium_16.copyWith(color: ColorsPalletes.white),
            ));
      },
    );
  }

  static showErrorToast({String message = 'Error'}) {
    showSimpleToast(message: message, bgColor: Colors.red.shade400);
  }

  static showSuccessToast({String message = 'Success'}) {
    showSimpleToast(message: message);
  }

  ///* Show Simple Toast
  static showSimpleToast({
    required String message,
    Color? bgColor,
    VoidCallback? onClose,
    Duration duration = const Duration(seconds: 2),
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      onClose: onClose,
      backButtonBehavior: BackButtonBehavior.close,
      align: Alignment.bottomCenter,
      useSafeArea: false,
      onlyOne: true,
      toastBuilder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: REdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: REdgeInsets.only(bottom: 36),
                      padding: REdgeInsets.symmetric(vertical: 15, horizontal: 24),
                      decoration: BoxDecoration(
                        color: bgColor ?? ColorsPalletes.primaryLightGreen.withOpacity(.9),
                        borderRadius: 58.r.br,
                      ),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyles.bold_14.copyWith(color: ColorsPalletes.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
