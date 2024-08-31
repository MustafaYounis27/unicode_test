import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';

class UnifiedBody extends StatefulWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget child;
  final List<Widget> actions;

  const UnifiedBody({
    super.key,
    required this.title,
    this.onBackPressed,
    required this.child,
    this.actions = const [],
  });

  @override
  State<UnifiedBody> createState() => _UnifiedBodyState();
}

class _UnifiedBodyState extends State<UnifiedBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNoromalAppBar,
        Expanded(child: widget.child),
      ],
    );
  }

  Widget get _buildNoromalAppBar {
    return Container(
      height: 0.12.sh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            ColorsPalletes.secondry100.withOpacity(0.3),
            Colors.white,
          ],
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Row(
          children: [
            if (Navigator.canPop(context)) ...[
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onBackPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 24.r,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              SizedBox(width: 20.r),
            ],
            Text(widget.title, style: TextStyles.medium_16.copyWith(color: ColorsPalletes.secondry900)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
