import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_ui_runner/io_components/app_initializer.dart';

class LenraApplicationModel extends ChangeNotifier {
  final String httpEndpoint;
  final String applicationName;
  final String accessToken;
  final String wsEndpoint;
  final String appName;
  final String baseRoute;
  final Map<String, String> customParams;
  late final List<RouteBase> routes;

  LenraApplicationModel({
    required this.httpEndpoint,
    required this.applicationName,
    required this.accessToken,
    required this.wsEndpoint,
    required this.appName,
    required this.baseRoute,
    this.customParams = const <String, String>{},
  }) {
    routes = [
      ShellRoute(
        builder: (context, state, child) {
          return AppInitializer(child);
        },
        routes: [
          // GoRoute(path: baseRoute, builder: ()),
        ],
      ),
    ];
  }

  set routes(List<RouteBase> newRoutes) {
    routes = newRoutes;
    notifyListeners();
  }
}
