import 'package:client_common/models/user_application_model.dart';
import 'package:client_common/views/stateful_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_ui_runner/io_components/lenra_router.dart';
import 'package:lenra_ui_runner/models/lenra_application_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
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

  final Widget Function(BuildContext, List<RouteBase>) builder;

  final String baseRoute;

  const App({
    Key? key,
    required this.appName,
    required this.httpEndpoint,
    required this.accessToken,
    required this.wsEndpoint,
    required this.builder,
    required this.baseRoute,
    this.customParams = const <String, String>{},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocketModel>(
            create: (context) => SocketModel(
                wsEndpoint: wsEndpoint, accessToken: accessToken, appName: appName, customParams: customParams)),
        ChangeNotifierProvider<LenraApplicationModel>(
          create: (context) => LenraApplicationModel(httpEndpoint, appName, accessToken),
        ),
      ],
      builder: (BuildContext context, _) {
        return LenraRouter(
          baseRoute: baseRoute,
          builder: builder,
        );
      },
    );
  }
}
