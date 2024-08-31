import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_button.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_text_form_field.dart';

class Alerts {
  final BuildContext _context;

  Alerts(this._context);

  Future<void> justAlert({String? title, required String body}) async {
    return await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Alert...'),
        content: Text(body),
        actions: [
          _okButton(() => Navigator.pop<bool>(context)),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Future<bool?> yesOrNoDialog({String? title, required String body}) async {
    return await showDialog<bool>(
      context: _context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Alert...'),
        content: Text(body),
        actions: [
          _yesButton(() => Navigator.pop<bool>(context, true)),
          _noButton(() => Navigator.pop<bool>(context, false)),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Future<String?> addTopic() async {
    TextEditingController controller = TextEditingController();

    return await showDialog<String>(
      context: _context,
      builder: (context) => AlertDialog(
        title: const Text('Add topic'),
        actions: [
          _cancelButton(() => Navigator.pop<String>(context)),
          _okButton(() => Navigator.pop<String>(context, controller.text)),
        ],
        content: UnifiedTextFormField(
          autoFocus: true,
          controller: controller,
          inputType: TextInputType.name,
          hintText: 'Topic',
          backgroundColor: Colors.white,
          onSubmit: (p0) => Navigator.pop<String>(context, controller.text),
        ),
      ),
    );
  }

  Widget _yesButton(Function() yesPressed) {
    return UnifiedButton(
      width: 0.3.sw,
      onPressed: () {
        yesPressed();
      },
      title: 'Yes',
    );
  }

  Widget _okButton(Function() yesPressed) {
    return UnifiedButton(
      width: 0.3.sw,
      onPressed: () {
        yesPressed();
      },
      title: 'Ok',
    );
  }

  Widget _noButton(Function() noPressed) {
    return UnifiedButton(
      width: 0.3.sw,
      color: ColorsPalletes.grey300,
      onPressed: () {
        noPressed();
      },
      title: 'No',
    );
  }

  Widget _cancelButton(Function() noPressed) {
    return UnifiedButton(
      width: 0.3.sw,
      color: ColorsPalletes.grey300,
      onPressed: () {
        noPressed();
      },
      title: 'cancel',
    );
  }
}
