import 'package:flutter/material.dart';

extension ThemeDataExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
