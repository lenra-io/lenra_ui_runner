import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

Widget createBaseTestWidgets({required Widget child}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<WidgetModel>(create: (_) => WidgetModel()),
      ChangeNotifierProvider<LenraApplicationModel>(
        create: (context) => LenraApplicationModel('foo-url', "appName", ''),
      ),
    ],
    child: MaterialApp(
      home: LenraTheme(
        themeData: LenraThemeData(),
        child: Scaffold(
          body: child,
        ),
      ),
    ),
  );
}
