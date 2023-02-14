import 'dart:async';

import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/lenra_application/api_error_snack_bar.dart';
import 'package:client_common/lenra_application/app_error_page.dart';
import 'package:client_common/lenra_application/lenra_error_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_socket.dart';
import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:json_patch/json_patch.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class LenraRoute extends StatefulWidget {
  final String route;
  LenraRoute(this.route);

  @override
  State<StatefulWidget> createState() {
    return LenraRouteState();
  }

  static LenraRouteIO of(BuildContext context) {
    var res = context.dependOnInheritedWidgetOfExactType<LenraRouteIO>();
    assert(res != null);
    return res!;
  }
}

class LenraRouteState extends State<LenraRoute> {
  LenraChannel? channel;
  bool hasError = false;
  bool isInitialized = false;
  ApiError? error;
  Map<String, dynamic>? ui;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupChannel(LenraSocket.of(context).socket);
    });
    super.initState();
  }

  void setupChannel(PhoenixSocket socket) {
    channel = LenraChannel(socket, "route:" + widget.route, {"mode": "lenra"});

    channel!.onError((response) {
      setState(() {
        hasError = true;
        isInitialized = true;
        error = ApiError.fromJson(response as Map<String, dynamic>);
      });
    });

    channel!.onUi((Map<String, dynamic>? newUi) {
      if (newUi == null) return;
      setState(() {
        if (!isInitialized) isInitialized = true;
        ui = newUi;
      });
    });

    channel!.onPatchUi((Map<dynamic, dynamic>? json) {
      Iterable<Map<String, dynamic>> patches = (json?["patch"] as Iterable).map((e) => e as Map<String, dynamic>);
      setState(() {
        ui = JsonPatch.apply(ui, patches, strict: false);
      });
    });

    channel!.onAppError((Map<dynamic, dynamic> json) {
      setState(() {
        if (!isInitialized) isInitialized = true;
        error = ApiError.fromJson(json as Map<String, dynamic>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Scaffold(body: LenraErrorPage(apiError: error!));
    }

    if (!isInitialized) {
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return LenraRouteIO(
      child: Scaffold(
        body: LenraWidget(
          error: error,
          ui: ui!,
          buildErrorPage: (BuildContext context, ApiError error) => AppErrorPage(apiError: error),
          showSnackBar: (BuildContext context, ApiError error) => {
            ScaffoldMessenger.of(context).showSnackBar(ApiErrorSnackBar(
              error: error,
              onPressAction: () => ScaffoldMessenger.of(context).clearSnackBars(),
              actionLabel: "Ok",
            )),
          },
        ),
      ),
      channel: channel!,
    );
  }

  @override
  void dispose() {
    channel?.close();
    super.dispose();
  }
}

class LenraRouteIO extends InheritedWidget {
  final LenraChannel channel;

  LenraRouteIO({required this.channel, required child}) : super(child: child);

  Future sendEvent(Event notification) {
    final completer = Completer();
    channel
        .send('run', notification.toMap())!
        .receive("ok", (body) => completer.complete(body))
        .receive("error", (error) => completer.completeError(error.toString()));
    return completer.future;
  }

  @override
  bool updateShouldNotify(covariant LenraRouteIO oldWidget) {
    return channel != oldWidget.channel;
  }
}