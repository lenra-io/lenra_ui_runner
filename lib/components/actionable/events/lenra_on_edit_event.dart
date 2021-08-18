import 'lenra_event.dart';

class LenraOnEditEvent extends LenraEvent {
  LenraOnEditEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
