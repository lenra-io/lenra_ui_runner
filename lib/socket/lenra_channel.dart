library socket;

import 'package:phoenix_wings/phoenix_wings.dart';

class LenraChannel {
  late PhoenixChannel _channel;
  final List<dynamic Function(Map<dynamic, dynamic>?)> _errorCallbacks = [];
  final List<dynamic Function(Map<dynamic, dynamic>?)> _responseCallbacks = [];
  LenraChannel(PhoenixSocket socket, String routeName, Map<String, dynamic> params) {
    _channel = socket.channel(routeName, params);
    _channel.join()?.receive("error", (Map<dynamic, dynamic>? response) {
      for (var c in _errorCallbacks) {
        c(response);
      }
    }).receive("ok", (Map<dynamic, dynamic>? response) {
      for (var c in _responseCallbacks) {
        c(response);
      }
    });
  }

  void close() {
    _channel.off("ui");
    _channel.off("patchUi");
    _channel.off("error");
    _channel.leave();
  }

  LenraChannel onUi(void Function(Map<String, dynamic>) callback) {
    _channel.on("ui", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload as Map<String, dynamic>);
    });
    return this;
  }

  LenraChannel onPatchUi(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("patchUi", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
    return this;
  }

  LenraChannel onNavTo(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("navTo", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
    return this;
  }

  LenraChannel onAppError(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("error", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
    return this;
  }

  LenraChannel onError(dynamic Function(Map<dynamic, dynamic>?) callback) {
    _errorCallbacks.add(callback);
    return this;
  }

  LenraChannel onResponse(dynamic Function(Map<dynamic, dynamic>?) callback) {
    _responseCallbacks.add(callback);
    return this;
  }

  PhoenixPush? send(String event, dynamic data) {
    return _channel.push(event: event, payload: data as Map<dynamic, dynamic>);
  }
}
