import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

Widget createBaseTestWidgets({required Widget child}) {
  return MaterialApp(
    home: LenraTheme(
      themeData: LenraThemeData(),
      child: Scaffold(
        body: child,
      ),
    ),
  );
}
