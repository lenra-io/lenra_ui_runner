import 'package:lenra_ui_runner/components/events/data/empty_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';

class OnPressedEvent extends Event {
  OnPressedEvent({required String code}) : super(code: code, data: EmptyData());
}
