import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:provider/provider.dart';

Widget createBaseTestWidgets({required Map<String, dynamic> ui, required Future Function(Event) sendEventFn}) {
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
          child: Scaffold(
            body: LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
              error: null,
              ui: ui,
            ),
          ),
        ),
      ),
      sendEventFn: sendEventFn,
    ),
  );
}
