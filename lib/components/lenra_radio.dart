import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import '../../lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_components/component/lenra_radio.dart';

import 'events/on_changed_event.dart';

// TODO : generate this from annotation on LenraRadio
class LenraRadioBuilder extends LenraComponentBuilder<LenraApplicationRadio> {
  // TODO : Handle focusNode
  @override
  LenraApplicationRadio map({autofocus, value, groupValue, materialTapTargetSize, onPressed, toggleable, style}) {
    return LenraApplicationRadio(
      autofocus: autofocus,
      value: value,
      groupValue: groupValue,
      materialTapTargetSize: materialTapTargetSize,
      onPressed: onPressed,
      toggleable: toggleable,
      style: style,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "autofocus": bool,
      "value": String,
      "groupValue": String,
      "materialTapTargetSize": MaterialTapTargetSize,
      "onPressed": Listener,
      "toggleable": bool,
      "style": LenraRadioStyle,
    };
  }
}

class LenraApplicationRadio extends StatelessWidget {
  final bool? autofocus;
  final String value;
  final String groupValue;
  final MaterialTapTargetSize? materialTapTargetSize;
  final lenra.Listener? onPressed;
  final bool? toggleable;
  final LenraRadioStyle? style;

  LenraApplicationRadio({
    required this.autofocus,
    required this.value,
    required this.groupValue,
    required this.materialTapTargetSize,
    required this.onPressed,
    required this.toggleable,
    required this.style,
  });

  void onRadioPressed(BuildContext context, String value) {
    if (onPressed != null) {
      OnChangedEvent(code: onPressed!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraRadio<String>(
      autofocus: autofocus ?? false,
      value: value,
      groupValue: groupValue,
      materialTapTargetSize: materialTapTargetSize,
      onPressed: (value) => onRadioPressed(context, groupValue),
      toggleable: toggleable ?? false,
      style: style,
    );
  }
}
