import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/lenra_application/api_error_snack_bar.dart';
import 'package:client_common/lenra_application/app_error_page.dart';
import 'package:client_common/lenra_application/lenra_error_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:provider/provider.dart';
import 'package:json_patch/json_patch.dart';

class Route extends StatefulWidget {
  final String route;
  Route(this.route);

  @override
  State<StatefulWidget> createState() {
    return RouteState();
  }
}

class RouteState extends State<Route> {
  late LenraChannel channel;
  bool hasError = false;
  bool isInitialized = false;
  ApiError? error;
  Map<dynamic, dynamic>? ui;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SocketModel socket = context.read<SocketModel>();
      channel = socket.channel(widget.route, {"mode": "lenra"});

      channel.onError((response) {
        hasError = true;
        isInitialized = true;
        error = ApiError.fromJson(response as Map<String, dynamic>);
      });

      channel.onUi((Map<dynamic, dynamic>? newUi) {
        if (newUi == null) return;
        if (!isInitialized) isInitialized = true;

        ui = newUi;
      });

      channel.onPatchUi((Map<dynamic, dynamic>? json) {
        Iterable<Map<String, dynamic>> patches = (json?["patch"] as Iterable).map((e) => e as Map<String, dynamic>);
        ui = JsonPatch.apply(ui, patches, strict: false);
      });

      channel.onAppError((Map<dynamic, dynamic> json) {
        if (!isInitialized) isInitialized = true;

        error = ApiError.fromJson(json as Map<String, dynamic>);
      });
    });
  }

  // Future sendEvent(Event notification) {
  //   final completer = Completer();
  //   channel!
  //       .send('run', notification.toMap())!
  //       .receive("ok", (body) => completer.complete(body))
  //       .receive("error", (error) => completer.completeError(error.toString()));
  //   return completer.future;
  // }

  void close() {
    channel.close();
  }

  @override
  Widget build(BuildContext context) {
    Widget res;
    if (hasError) {
      res = LenraErrorPage(apiError: error!);
    } else if (!isInitialized) {
      res = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      res = LenraWidget(
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
      );
    }
    return Scaffold(body: res);
  }
}
