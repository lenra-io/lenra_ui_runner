import 'package:flutter/material.dart';
import 'package:lenra_application/lenra_ui_controller.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:models/dev_tools_socket_model.dart';
import 'package:models/socket_model.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(DevTool());
}

class DevTool extends StatelessWidget {
  static final String appName = "test";

  @override
  Widget build(BuildContext context) {
    var themeData = LenraThemeData();

    return ChangeNotifierProvider<SocketModel>(
      create: (context) => DevToolsSocketModel(),
      builder: (BuildContext context, _) => LenraTheme(
        themeData: themeData,
        child: MaterialApp(
          title: 'DevTool',
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: themeData.lenraTextThemeData.bodyText),
          ),
          home: LenraUiController(appName),
        ),
      ),
    );
  }
}
