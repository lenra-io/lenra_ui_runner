import 'package:lenra_ui_runner/components/events/data/bool_data.dart';
import 'event.dart';

class OnPressedToggleEvent extends Event<BoolData> {
  OnPressedToggleEvent({
    required String code,
    required BoolData data,
  }) : super(code: code, data: data);
}
