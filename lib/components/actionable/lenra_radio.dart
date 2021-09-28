import 'package:flutter/material.dart';
import 'events/lenra_on_change_event.dart';
import 'lenra_actionable.dart';
import '../lenra_component.dart';
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
  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "label": "String",
      "groupValue": "String",
      "disabled": "bool",
      "onPressed": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationRadio extends StatelessLenraComponent
    implements LenraActionable {
  final String value;
  final String groupValue;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? onPressed;

  LenraApplicationRadio({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.disabled,
    required this.onPressed,
  });

  void onRadioPressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      LenraOnChangeEvent(code: onPressed!['code']!, event: {})
          .dispatch(context);
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
