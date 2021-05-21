import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_change_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_checkbox.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder extends LenraComponentBuilder<LenraApplicationCheckbox> {
  LenraApplicationCheckbox map({value, label, disabled, listeners}) {
    return LenraApplicationCheckbox(value: value, label: label, disabled: disabled, listeners: listeners);
  }

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
  final String label;
  final bool value;
  final bool disabled;
  final Map<String, dynamic> listeners;

  LenraApplicationCheckbox({
    this.value,
    this.label,
    this.disabled,
    this.listeners,
  }) : super();

  void onChanged(bool newValue, BuildContext context) {
    if (this.listeners != null) {
      final Map<String, dynamic> listener = this.listeners['onChange'];
      if (listener != null) {
        LenraOnChangeEvent(code: listener['code'], event: {
          "value": newValue,
        }).dispatch(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraCheckbox(
      value: this.value,
      label: this.label,
      disabled: this.disabled ?? false,
      onChanged: (bool value) => this.onChanged(value, context),
    );
  }
}