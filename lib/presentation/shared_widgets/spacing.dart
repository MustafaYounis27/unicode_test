import 'package:flutter/material.dart';

SizedBox verticalSpace(double size) => SizedBox(height: size);
SizedBox horizontalSpace(double size) => SizedBox(width: size);

WidgetSpan horizontalSpanSpace(double size) =>
    WidgetSpan(child: SizedBox(width: size));
WidgetSpan verticalSpanSpace(double size) =>
    WidgetSpan(child: SizedBox(height: size));
