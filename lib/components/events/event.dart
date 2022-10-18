//? Here is defined all Event types that can be send to the server.

abstract class Jsonifiable {
  Map<String, dynamic> toMap();
}

class Event<T extends Jsonifiable> {
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
