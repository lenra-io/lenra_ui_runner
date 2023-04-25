import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:provider/provider.dart';

Widget createBaseTestWidgets({required Widget child, required Future Function(Event) sendEventFn}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LenraApplicationModel>(
        create: (context) => LenraApplicationModel(
          httpEndpoint: 'foo-url',
          applicationName: "appName",
          accessToken: '',
        ),
      ),
    ],
    child: EventManager(
      child: MaterialApp(
        home: LenraTheme(
          themeData: LenraThemeData(),
          child: Scaffold(body: child),
        ),
      ),
      sendEventFn: sendEventFn,
    ),
  );
}
