import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatelessWidget {
  final Widget child;

  AppInitializer(this.child);
  @override
  Widget build(BuildContext context) {
    LenraApplicationModel am = context.read<LenraApplicationModel>();
    return ChangeNotifierProvider<SocketModel>(
      create: (context) => SocketModel(
        wsEndpoint: am.wsEndpoint,
        accessToken: am.accessToken,
        appName: am.appName,
        customParams: am.customParams,
      ),
      builder: (BuildContext context, _) {
        return child;
      },
    );
  }
}
