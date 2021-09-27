import 'package:flutter/material.dart';
import 'events/lenra_on_change_event.dart';
import 'lenra_actionable.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_radio.dart';

// TODO : generate this from annotation on LenraRadio
class LenraRadioBuilder extends LenraComponentBuilder<LenraApplicationRadio> {
  @override
  LenraApplicationRadio map({value, label, groupValue, disabled, listeners}) {
    return LenraApplicationRadio(
      value: value,
      label: label,
      groupValue: groupValue,
      disabled: disabled,
      listeners: listeners,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "label": "String",
      "groupValue": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationRadio extends StatelessLenraComponent implements LenraActionable {
  final String value;
  final String groupValue;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? listeners;

  LenraApplicationRadio({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.disabled,
    required this.listeners,
  });

  void onChanged(String? newValue, BuildContext context) {
    final Map<String, String>? listener = listeners?['onChange'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnChangeEvent(code: listener['code']!, event: {
        "value": newValue,
      }).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraRadio<String>(
      value: value,
      label: label,
      groupValue: groupValue,
      disabled: disabled ?? false,
      onChanged: (String? newValue) => onChanged(newValue, context),
    );
  }
}
