import 'lenra_event.dart';

class LenraOnChangeEvent extends LenraEvent {
  LenraOnChangeEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
