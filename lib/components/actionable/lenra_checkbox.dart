import 'package:flutter/material.dart';
import 'events/lenra_on_change_event.dart';
import 'lenra_actionable.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder extends LenraComponentBuilder<LenraApplicationCheckbox> {
  @override
  LenraApplicationCheckbox map({value, label, disabled, listeners}) {
    return LenraApplicationCheckbox(value: value, label: label, disabled: disabled, listeners: listeners);
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "value": "bool",
      "label": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationCheckbox extends StatelessLenraComponent implements LenraActionable {
  final bool value;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? listeners;

  LenraApplicationCheckbox({
    required this.value,
    required this.label,
    required this.disabled,
    required this.listeners,
  }) : super();

  void onChanged(bool? newValue, BuildContext context) {
    final Map<String, String>? listener = listeners?['onChange'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnChangeEvent(code: listener['code']!, event: {
        "value": newValue,
      }).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraCheckbox(
      value: value,
      label: label,
      disabled: disabled ?? false,
      onChanged: (bool? value) => onChanged(value, context),
    );
  }
}
