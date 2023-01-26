import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/io_components/lenra_routes.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';

class LenraSocket extends StatefulWidget {
  final String accessToken;
  final String appName;
  final String wsEndpoint;
  final Map<String, String> customParams;

  LenraSocket({
    required this.accessToken,
    required this.appName,
    required this.wsEndpoint,
    required this.customParams,
  });

  @override
  State<StatefulWidget> createState() {
    return LenraSocketState();
  }

  static LenraSocketIO of(BuildContext context) {
    var res = context.dependOnInheritedWidgetOfExactType<LenraSocketIO>();
    assert(res != null);
    return res!;
  }
}

class LenraSocketState extends State<LenraSocket> {
  PhoenixSocket? _socket;
  late Future<PhoenixSocket> future;

  @override
  void initState() {
    future = connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<PhoenixSocket> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return LenraSocketIO(
            socket: snapshot.data!,
            child: LenraRoutes(snapshot.data!),
          );
        }
        return CircularProgressIndicator();
      },
      future: future,
    );
  }

  Future<PhoenixSocket> connect() {
    Completer<PhoenixSocket> completer = Completer();
    Map<String, String> baseParams = {"token": widget.accessToken, "app": widget.appName};
    baseParams.addAll(widget.customParams);

    setState(() {
      _socket = createPhoenixSocket(
        widget.wsEndpoint,
        baseParams,
      );
    });

    _socket!.connect();
    _socket!.onOpen(() {
      completer.complete(_socket);
    });
    _socket!.onError((error) {
      completer.completeError("Can't connect to the socket.");
    });

    return completer.future;
  }

  @override
  void dispose() {
    _socket?.disconnect();
    super.dispose();
  }
}

class LenraSocketIO extends InheritedWidget {
  final PhoenixSocket socket;

  LenraSocketIO({required this.socket, required child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant LenraSocketIO oldWidget) {
    return socket != oldWidget.socket;
  }
}
