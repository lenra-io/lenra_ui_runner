import 'package:lenra_ui_runner/components/events/event.dart';

class ValueData implements Jsonifiable {
  String value;

  ValueData(this.value);

  @override
  Map<String, dynamic> toMap() {
    return {
      "value": value,
    };
  }
}
