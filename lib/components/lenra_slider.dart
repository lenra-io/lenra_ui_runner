import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_components/theme/lenra_slider_style.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraButton
class LenraSliderBuilder extends LenraComponentBuilder<LenraApplicationSlider> {
  @override
  LenraApplicationSlider map({style, autofocus, divisions, label, max, min, onChanged, onChangeEnd, onChangeStart, value}) {
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
  final LenraSliderStyle style;
  final bool autofocus;
  final int divisions;
  final String label;
  final double max;
  final double min;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final ValueChanged<double> onChangeStart;
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

  @override
  Widget build(BuildContext context) {
    return LenraSlider(
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
}
