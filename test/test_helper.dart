import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:provider/provider.dart';

import 'mock_channel_model.dart';

Widget createBaseTestWidgets({required Widget child}) {
  return Builder(
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider<ChannelModel>(create: (_) => MockChannelModel(context: context)),
        ChangeNotifierProvider<LenraApplicationModel>(
          create: (context) => LenraApplicationModel(
            httpEndpoint: 'foo-url',
            applicationName: "appName",
            accessToken: '',
          ),
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
    ),
  );
}
