import 'package:client_common/views/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_components/theme/lenra_slider_style.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:provider/provider.dart';
import 'events/data/value_data.dart';
import 'events/on_changed_event.dart';

// TODO : generate this from annotation on LenraSlider
class LenraSliderBuilder extends LenraComponentBuilder<LenraApplicationSlider> {
  @override
  LenraApplicationSlider map({
    style,
    autofocus,
    divisions,
    label,
    max,
    min,
    onChanged,
    onChangeEnd,
    onChangeStart,
    value,
    name,
  }) {
    return LenraApplicationSlider(
      style: style,
      autofocus: autofocus,
      divisions: divisions,
      label: label,
      max: max,
      min: min,
      onChanged: onChanged,
      onChangeEnd: onChangeEnd,
      onChangeStart: onChangeStart,
      value: value,
      name: name,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "style": LenraSliderStyle,
      "autofocus": bool,
      "divisions": int,
      "label": String,
      "max": double,
      "min": double,
      "onChanged": lenra.Listener,
      "onChangeEnd": lenra.Listener,
      "onChangeStart": lenra.Listener,
      "value": double,
      "name": String,
    };
  }
}

class LenraApplicationSlider extends StatelessWidget {
  final LenraSliderStyle? style;
  final bool? autofocus;
  final int? divisions;
  final String? label;
  final double max;
  final double min;
  final lenra.Listener? onChanged;
  final lenra.Listener? onChangeEnd;
  final lenra.Listener? onChangeStart;
  final double value;
  final String? name;

  LenraApplicationSlider({
    required this.style,
    required this.autofocus,
    required this.divisions,
    required this.label,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.onChangeEnd,
    required this.onChangeStart,
    required this.value,
    required this.name,
  }) : super();

  void onSliderChange(BuildContext context, double value) {
    if (name != null) {
      context.read<FormProvider?>()?.setFormFieldValue(name!, value);
    }
    if (onChanged != null) {
      onChanged!.run(context, (code) => OnChangedEvent(code: code, data: ValueData(value)));
    }
  }

  void onSliderChangeEnd(BuildContext context, double value) {
    if (onChangeEnd != null) {
      onChangeEnd!.run(context, (code) => OnChangedEvent(code: code, data: ValueData(value)));
    }
  }

  void onSliderChangeStart(BuildContext context, double value) {
    if (onChangeStart != null) {
      onChangeStart!.run(context, (code) => OnChangedEvent(code: code, data: ValueData(value)));
    }
  }

  @override
  Widget build(BuildContext context) {
    double? formValue;

    if (name != null) {
      formValue = context.select<FormProvider?, double?>((form) => form?.formFieldValues[name]);
    }

    Widget res = LenraSlider(
      style: style,
      autofocus: autofocus ?? true,
      divisions: divisions,
      label: label,
      max: max,
      min: min,
      onChanged: (value) {
        onSliderChange(context, value);
      },
      onChangeEnd: (value) => onSliderChangeEnd(context, value),
      onChangeStart: (value) => onSliderChangeStart(context, value),
      value: formValue ?? value,
    );

    if (name != null) {
      return StatefulWrapper(
        onInit: () {
          context.read<FormProvider?>()?.initFormFieldValue(name!, value);
        },
        builder: (context) {
          return res;
        },
      );
    }

    return res;
  }
}
