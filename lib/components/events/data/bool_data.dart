import 'package:lenra_ui_runner/components/events/event.dart';

class BoolData implements Jsonifiable {
  bool value;

  BoolData(this.value);

  @override
  Map<String, dynamic> toMap() {
    return {
      "value": value,
    };
  }
}
