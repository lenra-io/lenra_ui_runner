import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/app.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:provider/provider.dart';

import 'mock_socket_model.dart';

Widget createBaseTestWidgets() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<SocketModel>(
        create: (context) {
          return MockSocketModel(1, "appName");
        },
      ),
    ],
    builder: (context, _) => MaterialApp(
      home: LenraTheme(
        themeData: LenraThemeData(),
        child: Scaffold(
          body: App(
            appName: "appName",
            httpEndpoint: 'foo-url',
            accessToken: "",
            wsEndpoint: "ws://localhost:4001/socket/websocket",
            baseRoute: "/",
            routeWidget: LenraRoute("/"),
            navTo: (context, route) {},
          ),
        ),
      ),
    ),
  );
}
