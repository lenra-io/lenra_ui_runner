import 'components/actionable/events/lenra_event.dart';

class LenraOnLongPressEvent extends LenraEvent {
  LenraOnLongPressEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
