import 'lenra_event.dart';

class LenraOnFocusChangeEvent extends LenraEvent {
  LenraOnFocusChangeEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
