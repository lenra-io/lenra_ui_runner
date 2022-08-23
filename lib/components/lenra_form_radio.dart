import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:provider/provider.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_components/component/lenra_radio.dart';

import 'events/on_changed_event.dart';

class LenraApplicationFormRadio extends StatelessWidget {
  final bool? autofocus;
  final String value;
  final String groupValue;
  final MaterialTapTargetSize? materialTapTargetSize;
  final lenra.Listener? onPressed;
  final bool? toggleable;
  final LenraRadioStyle? style;
  final String name;

  LenraApplicationFormRadio({
    required this.autofocus,
    required this.value,
    required this.groupValue,
    required this.materialTapTargetSize,
    required this.onPressed,
    required this.toggleable,
    required this.style,
    required this.name,
  });

  void onRadioPressed(BuildContext context, String value) {
    if (onPressed != null) {
      context.read<FormProvider?>()?.setFormFieldValue(name, value);

      OnChangedEvent(code: onPressed!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (value == groupValue) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<FormProvider?>()?.setFormFieldValue(name, value);
      });
    }

    String? formGroupValue = context.select<FormProvider?, String?>((form) => form?.formFieldValues[name]);

    return LenraRadio<String>(
      autofocus: autofocus ?? false,
      value: value,
      groupValue: formGroupValue ?? groupValue,
      materialTapTargetSize: materialTapTargetSize,
      onPressed: onPressed == null ? null : (value) => onRadioPressed(context, value!),
      toggleable: toggleable ?? false,
      style: style,
    );
  }
}
