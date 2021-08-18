import 'lenra_event.dart';

class LenraOnSubmitEvent extends LenraEvent {
  LenraOnSubmitEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
