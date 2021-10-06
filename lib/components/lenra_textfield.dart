import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import '../../lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

// TODO : generate this from annotation on LenraTextfield
class LenraTextfieldBuilder extends LenraComponentBuilder<LenraApplicationTextfield> {
  @override
  LenraApplicationTextfield map({
    value,
    label,
    hintText,
    description,
    errorMessage,
    obscure,
    disabled,
    inRow,
    error,
    width,
    onChanged,
    size,
  }) {
    return LenraApplicationTextfield(
      value: value,
      label: label,
      hintText: hintText,
      description: description,
      errorMessage: errorMessage,
      obscure: obscure,
      disabled: disabled,
      inRow: inRow,
      error: error,
      width: width,
      onChanged: onChanged,
      size: size,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": String,
      "label": String,
      "hintText": String,
      "description": String,
      "errorMessage": String,
      "obscure": bool,
      "disabled": bool,
      "inRow": bool,
      "error": bool,
      "width": double,
      "onChanged": Listener,
      "size": LenraComponentSize
    };
  }
}

// ignore: must_be_immutable
class LenraApplicationTextfield extends StatelessWidget {
  String? label;
  String? hintText;
  String? description;
  String? errorMessage;
  bool? obscure;
  bool? disabled;
  bool? inRow;
  bool? error;
  double? width;
  LenraComponentSize? size;
  final lenra.Listener? onChanged;
  final FocusNode _focusNode;
  final TextEditingController _controller;

  LenraApplicationTextfield({
    required String value,
    required this.label,
    required this.hintText,
    required this.description,
    required this.errorMessage,
    required this.obscure,
    required this.disabled,
    required this.inRow,
    required this.error,
    required this.width,
    required this.size,
    required this.onChanged,
  })  : _controller = TextEditingController(text: value),
        _focusNode = FocusNode(),
        super();

  @override
  Widget build(BuildContext context) {
    return LenraTextField(
      label: label,
      hintText: hintText,
      description: description,
      errorMessage: errorMessage,
      obscure: obscure ?? false,
      disabled: disabled ?? false,
      inRow: inRow ?? false,
      error: error ?? false,
      onSubmitted: (value) {
        if (onChanged != null) {
          OnChangedEvent(code: onChanged!.code, data: ValueData(value)).dispatch(context);
        }
      },
      size: size ?? LenraComponentSize.medium,
      width: width ?? 200.0,
      focusNode: _focusNode,
      controller: _controller,
    );
  }
}
