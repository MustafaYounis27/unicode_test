import 'package:flutter/cupertino.dart';
import 'package:unicode_test/core/theme/colors.dart';

class LoadingIndicator extends StatefulWidget {
  final Color? color;
  const LoadingIndicator({super.key, this.color});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CupertinoActivityIndicator(color: widget.color ?? ColorsPalletes.kPrimarySwatch),
      ),
    );
  }
}
