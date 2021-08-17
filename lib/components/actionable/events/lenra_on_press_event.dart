import 'components/actionable/events/lenra_event.dart';

class LenraOnPressEvent extends LenraEvent {
  LenraOnPressEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
