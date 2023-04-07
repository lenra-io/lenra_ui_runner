import 'package:lenra_ui_runner/io_components/lenra_socket.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/models/lenra_route_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  /// The name of the Lenra application.
  final String appName;

  final String routeName = "/";

  /// The URL of the Lenra server.
  final String httpEndpoint;

  /// The URL of the Lenra socket.
  final String wsEndpoint;

  /// The access token to use for the Lenra server.
  final String accessToken;

  final Map<String, String> customParams;

  final String baseRoute;

  final Widget routeWidget;

  final void Function(BuildContext, String) navTo;

  const App({
    Key? key,
    required this.appName,
    required this.httpEndpoint,
    required this.accessToken,
    required this.wsEndpoint,
    required this.baseRoute,
    required this.routeWidget,
    required this.navTo,
    this.customParams = const <String, String>{},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LenraApplicationModel>(
          create: (context) => LenraApplicationModel(
            httpEndpoint: httpEndpoint,
            applicationName: appName,
            accessToken: accessToken,
          ),
        ),
        ChangeNotifierProxyProvider0<LenraRouteModel>(
          create: (context) => LenraRouteModel(
            baseRoute: baseRoute,
            navTo: navTo,
            routeWidget: routeWidget,
          ),
          update: (context, lenraRouteModel) => lenraRouteModel!.update(routeWidget),
        ),
      ],
      child: LenraSocket(
        accessToken: accessToken,
        appName: appName,
        wsEndpoint: wsEndpoint,
        customParams: customParams,
      ),
    );
  }
}