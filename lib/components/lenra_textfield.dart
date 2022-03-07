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
    autofillHints,
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
      autofillHints: autofillHints,
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
      "onChanged": lenra.Listener,
      "size": LenraComponentSize,
      "minLines": int,
      "maxLines": int,
      "autofillHints": AutofillHints,
    };
  }
}

// ignore: must_be_immutable
class LenraApplicationTextfield extends StatefulWidget {
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
  _TimeoutStrategy timeoutStrategy = _AtMostTimeout(duration: Duration(milliseconds: 500));
  String value;
  Iterable<String>? autofillHints;

  LenraApplicationTextfield({
    required this.value,
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
    required this.autofillHints,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return LenraApplicationTextfieldState();
  }
}

class LenraApplicationTextfieldState extends State<LenraApplicationTextfield> {
  final FocusNode _focusNode;
  late final TextEditingController _controller;

  LenraApplicationTextfieldState() : _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  void handleTimeout(BuildContext context, String value) {
    OnChangedEvent(code: widget.onChanged!.code, data: ValueData(value)).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    return LenraTextField(
      label: widget.label,
      hintText: widget.hintText,
      description: widget.description,
      errorMessage: widget.errorMessage,
      obscure: widget.obscure ?? false,
      disabled: widget.disabled ?? false,
      inRow: widget.inRow ?? false,
      error: widget.error ?? false,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.timeoutStrategy.onChanged(context, value, widget.onChanged!.code);
        }
      },
      size: widget.size ?? LenraComponentSize.medium,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      width: widget.width ?? 200.0,
      autofillHints: widget.autofillHints,
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

// ignore: unused_element
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
