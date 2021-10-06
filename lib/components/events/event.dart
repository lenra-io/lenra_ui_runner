//? Here is defined all Event types that can be send to the server.
import 'package:flutter/material.dart';

abstract class Jsonifiable {
  Map<String, dynamic> toMap();
}

class Event<T extends Jsonifiable> extends Notification {
  Event({
    required this.code,
    required this.data,
  }) : super();
  final String code;
  final T data;

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "event": data.toMap(),
    };
  }
}
