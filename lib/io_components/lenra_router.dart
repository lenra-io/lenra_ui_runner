import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:provider/provider.dart';

class LenraRouter extends StatefulWidget {
  final Widget Function(BuildContext, List<RouteBase>) builder;
  final String baseRoute;

  LenraRouter({required this.builder, required this.baseRoute});

  static LenraRouterIO of(BuildContext context) {
    var res = context.dependOnInheritedWidgetOfExactType<LenraRouterIO>();
    assert(res != null);
    return res!;
  }

  @override
  State<StatefulWidget> createState() {
    return LenraRouterState();
  }
}

class LenraRouterState extends State<LenraRouter> {
  LenraChannel? channel;

  // List<dynamic>? routes;
  List<RouteBase> goRoutes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupChannel();
    });
  }

  void setupChannel() {
    channel = context.read<SocketModel>().channel("routes", {"mode": "lenra"});

    channel!.onError((error) {
      print("Error");
      print(error);
    });

    channel!.onResponse((response) {
      setState(() {
        goRoutes = buildGoRoutes(response!["lenraRoutes"] as List<dynamic>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LenraRouterIO(baseRoute: widget.baseRoute, child: widget.builder(context, goRoutes));
  }

  List<RouteBase> buildGoRoutes(List<dynamic>? routes) {
    List<GoRoute> goRoutes;

    if (routes == null) {
      goRoutes = [GoRoute(path: widget.baseRoute, builder: (c, s) => CircularProgressIndicator())];
    } else {
      goRoutes = routes.map((route) {
        Map<String, dynamic> typedRoute = route as Map<String, dynamic>;
        String path = typedRoute["path"] == "/" ? widget.baseRoute : widget.baseRoute + typedRoute["path"];
        return GoRoute(
          path: path,
          builder: (BuildContext context, GoRouterState routerState) => LenraRoute(typedRoute["path"]),
        );
      }).toList();
    }

    return [
      ShellRoute(
        builder: (context, state, child) {
          return child;
        },
        routes: goRoutes,
      ),
    ];
  }

  @override
  void dispose() {
    channel?.close();
    super.dispose();
  }
}

class LenraRouterIO extends InheritedWidget {
  final String baseRoute;

  LenraRouterIO({required this.baseRoute, required child}) : super(child: child);

  Future navTo(BuildContext context, String path) {
    String goTo = path == "/" ? baseRoute : baseRoute + path;

    GoRouter.of(context).go(goTo);
    return Future.value(true);
  }

  @override
  bool updateShouldNotify(covariant LenraRouterIO oldWidget) {
    return baseRoute != oldWidget.baseRoute;
  }
}
