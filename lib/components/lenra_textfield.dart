import 'dart:async';

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
    minLines,
    maxLines,
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
      minLines: minLines,
      maxLines: maxLines,
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
      "size": LenraComponentSize,
      "minLines": int,
      "maxLines": int,
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
  int? minLines;
  int? maxLines;
  final FocusNode _focusNode;
  final TextEditingController _controller;
  _TimeoutStrategy timeoutStrategy = _AtMostTimeout(duration: Duration(milliseconds: 500));

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
    required this.minLines,
    required this.maxLines,
    required this.onChanged,
  })  : _controller = TextEditingController(text: value),
        _focusNode = FocusNode(),
        super();

  void handleTimeout(BuildContext context, String value) {
    OnChangedEvent(code: onChanged!.code, data: ValueData(value)).dispatch(context);
  }

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
      onChanged: (value) {
        if (onChanged != null) {
          timeoutStrategy.onChanged(context, value, onChanged!.code);
        }
      },
      size: size ?? LenraComponentSize.medium,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      width: width ?? 200.0,
      focusNode: _focusNode,
      controller: _controller,
    );
  }
}

abstract class _TimeoutStrategy {
  Duration duration;
  _TimeoutStrategy({
    required this.duration,
  });
  void onChanged(BuildContext context, String value, String code);
}

class _AtLeastTimeout extends _TimeoutStrategy {
  Timer? time;
  _AtLeastTimeout({
    Duration duration = const Duration(milliseconds: 500),
  }) : super(duration: duration);

  void _handleTimeout(BuildContext context, String value, String code) {
    OnChangedEvent(code: code, data: ValueData(value)).dispatch(context);
  }

  @override
  void onChanged(BuildContext context, String value, String code) {
    if (time != null && time!.isActive) {
      time!.cancel();
    }
    time = Timer(duration, () => _handleTimeout(context, value, code));
  }
}

class _AtMostTimeout extends _TimeoutStrategy {
  String currentValue = "";
  Timer? time;

  _AtMostTimeout({
    Duration duration = const Duration(milliseconds: 500),
  }) : super(duration: duration);

  void _handleTimeout(BuildContext context, String code) {
    OnChangedEvent(code: code, data: ValueData(currentValue)).dispatch(context);
  }

  @override
  void onChanged(BuildContext context, String value, String code) {
    currentValue = value;
    if (time == null || !time!.isActive) {
      time = Timer(duration, () => _handleTimeout(context, code));
    }
  }
}
