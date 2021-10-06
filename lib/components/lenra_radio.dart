import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import '../../lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_radio.dart';

// TODO : generate this from annotation on LenraRadio
class LenraRadioBuilder extends LenraComponentBuilder<LenraApplicationRadio> {
  @override
  LenraApplicationRadio map({value, label, groupValue, disabled, onPressed}) {
    return LenraApplicationRadio(
      value: value,
      label: label,
      groupValue: groupValue,
      disabled: disabled,
      onPressed: onPressed,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": String,
      "label": String,
      "groupValue": String,
      "disabled": bool,
      "onPressed": Listener,
    };
  }
}

class LenraApplicationRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final String? label;
  final bool? disabled;
  final lenra.Listener? onPressed;

  LenraApplicationRadio({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.disabled,
    required this.onPressed,
  });

  void onRadioPressed(BuildContext context) {
    if (onPressed != null) {
      OnPressedEvent(code: onPressed!.code).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraRadio<String>(
      value: value,
      label: label,
      groupValue: groupValue,
      disabled: disabled ?? false,
      onPressed: () => onRadioPressed(context),
    );
  }
}
