import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_components/theme/lenra_slider_style.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'events/data/value_data.dart';
import 'events/on_changed_event.dart';

// TODO : generate this from annotation on LenraSlider
class LenraSliderBuilder extends LenraComponentBuilder<LenraApplicationSlider> {
  @override
  LenraApplicationSlider map(
      {style, autofocus, divisions, label, max, min, onChanged, onChangeEnd, onChangeStart, value}) {
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
      "onChanged": Listener,
      "onChangeEnd": Listener,
      "onChangeStart": Listener,
      "value": double,
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
  }) : super();

  void onSliderChange(BuildContext context, double value) {
    if (onChanged != null) {
      OnChangedEvent(code: onChanged!.code, data: ValueData(value)).dispatch(context);
    }
  }

  void onSliderChangeEnd(BuildContext context, double value) {
    if (onChangeEnd != null) {
      OnChangedEvent(code: onChanged!.code, data: ValueData(value)).dispatch(context);
    }
  }

  void onSliderChangeStart(BuildContext context, double value) {
    if (onChangeStart != null) {
      OnChangedEvent(code: onChanged!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraSlider(
      style: style,
      autofocus: autofocus ?? true,
      divisions: divisions,
      label: label,
      max: max,
      min: min,
      onChanged: (value) => onSliderChange(context, value),
      onChangeEnd: (value) => onSliderChangeEnd(context, value),
      onChangeStart: (value) => onSliderChangeStart(context, value),
      value: value,
    );
  }
}