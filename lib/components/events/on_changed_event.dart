import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'event.dart';

class OnChangedEvent extends Event<ValueData> {
  OnChangedEvent({
    required String code,
    required ValueData data,
  }) : super(code: code, data: data);
}
