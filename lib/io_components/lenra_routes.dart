import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/models/lenra_route_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:phoenix_wings/html.dart';
import 'package:provider/provider.dart';

class LenraRoutes extends StatefulWidget {
  final PhoenixSocket socket;
  LenraRoutes(this.socket);

  @override
  State<StatefulWidget> createState() {
    return LenraRoutesState();
  }
}

class LenraRoutesState extends State<LenraRoutes> {
  LenraChannel? _channel;
  late Future<List<dynamic>> future;

  @override
  void initState() {
    future = loadRoutes(widget.socket);

    _channel!.onNavTo((Map<dynamic, dynamic>? newPage) {
      if (newPage == null) return;
      print("RECEIVED ON NAV TO");
      print("NAV TO PAGE $newPage");
      // setState(() {
      //   if (!isInitialized) isInitialized = true;
      //   ui = newUi;
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Widget routeWidget = context.select<LenraRouteModel, Widget>((model) => model.routeWidget);
          return routeWidget;
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<dynamic>> loadRoutes(PhoenixSocket socket) {
    Completer<List<dynamic>> completer = Completer();
    setState(() {
      _channel = LenraChannel(socket, "routes", {"mode": "lenra"});
    });

    _channel!.onError((error) {
      completer.completeError("Route channel connexion failed");
    });

    _channel!.onResponse((response) {
      if (!completer.isCompleted) {
        completer.complete(response!["lenraRoutes"] as List<dynamic>);
      }
    });

    return completer.future;
  }

  @override
  void dispose() {
    _channel?.close();
    super.dispose();
  }
}
