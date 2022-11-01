import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/models/app_socket_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/models/widget_model.dart';
import 'package:provider/provider.dart';

import 'mock_channel_model.dart';

Widget createBaseTestWidgets({required Widget child}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ChannelModel>(create: (_) => MockChannelModel()),
      ChangeNotifierProvider<WidgetModel>(
        create: (ctx) => WidgetModel(
          channelModel: ctx.read<ChannelModel>(),
        ),
      ),
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
