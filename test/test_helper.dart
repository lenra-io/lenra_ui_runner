import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

import 'mock_channel_model.dart';

Widget createBaseTestWidgets({required Widget child}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ViewModel>(create: (_) => ViewModel<String>()),
      ChangeNotifierProvider<ChannelModel>(create: (_) => MockChannelModel()),
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
