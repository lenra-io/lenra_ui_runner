import 'package:lenra_ui_runner/components/events/event.dart';

class EmptyData implements Jsonifiable {
  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
