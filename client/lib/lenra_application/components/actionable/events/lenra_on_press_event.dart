import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';

class LenraOnPressEvent extends LenraEvent {
  LenraOnPressEvent({@required String code, @required Map<String, dynamic> event})
      : super(code: code, event: event);
}