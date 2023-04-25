import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/utils/lenra_text_field_style.dart';
import 'package:provider/provider.dart';
import '../../lenra_component_builder.dart';

// TODO : generate this from annotation on LenraTextfield
class LenraTextfieldBuilder extends LenraComponentBuilder<LenraApplicationTextfield> {
  @override
  LenraApplicationTextfield map({
    value,
    autocorrect,
    autofillHints,
    autofocus,
    buildCounter,
    style,
    dragStartBehavior,
    enabled,
    enableInteractiveSelection,
    expands,
    keyboardType,
    maxLength,
    maxLengthEnforcement,
    maxLines,
    minLines,
    obscureText,
    onAppPrivateCommand,
    onChanged,
    onEditingComplete,
    onSubmitted,
    onTap,
    readOnly,
    showCursor,
    textCapitalization,
    textDirection,
    textInputAction,
    toolbarOptions,
    name,
  }) {
    return LenraApplicationTextfield(
      value: value,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      buildCounter: buildCounter,
      style: style,
      dragStartBehavior: dragStartBehavior,
      enabled: enabled,
      enableInteractiveSelection: enableInteractiveSelection,
      expands: expands,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      onAppPrivateCommand: onAppPrivateCommand,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly,
      showCursor: showCursor,
      textCapitalization: textCapitalization,
      textDirection: textDirection,
      textInputAction: textInputAction,
      toolbarOptions: toolbarOptions,
      name: name,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": String,
      "autocorrect": bool,
      "autofillHints": List,
      "autofocus": bool,
      "buildCounter": Widget, // TODO Check on Image
      "style": LenraTextFieldStyle,
      "dragStartBehavior": DragStartBehavior,
      "enabled": bool,
      "enableInteractiveSelection": bool,
      "expands": bool,
      "keyboardType": TextInputType,
      "maxLength": int,
      "maxLenghtEnforcement": MaxLengthEnforcement,
      "maxLines": int,
      "minLines": int,
      "obscureText": bool,
      "onAppPrivateCommand": lenra.Listener,
      "onChanged": lenra.Listener,
      "onEditingComplete": lenra.Listener,
      "onSubmitted": lenra.Listener,
      "onTap": lenra.Listener,
      "readOnly": bool,
      "showCursor": bool,
      "textCapitalization": TextCapitalization,
      "textDirection": TextDirection,
      "textInputAction": TextInputAction,
      // ignore: deprecated_member_use
      "toolbarOptions": ToolbarOptions,
      "name": String,
    };
  }
}

// ignore: must_be_immutable
class LenraApplicationTextfield extends StatefulWidget {
  String value;
  bool? autocorrect;
  List<String>? autofillHints;
  bool? autofocus;
  InputCounterWidgetBuilder? buildCounter;
  LenraTextFieldStyle? style;
  DragStartBehavior? dragStartBehavior;
  bool? enabled;
  bool? enableInteractiveSelection;
  bool? expands;
  TextInputType? keyboardType;
  int? maxLength;
  MaxLengthEnforcement? maxLengthEnforcement;
  int? maxLines;
  int? minLines;
  bool? obscureText;
  lenra.Listener? onAppPrivateCommand;
  lenra.Listener? onChanged;
  lenra.Listener? onEditingComplete;
  lenra.Listener? onSubmitted;
  lenra.Listener? onTap;
  bool? readOnly;
  bool? showCursor;
  TextCapitalization? textCapitalization;
  TextDirection? textDirection;
  TextInputAction? textInputAction;
  // ignore: deprecated_member_use
  ToolbarOptions? toolbarOptions;
  String? name;

  LenraApplicationTextfield({
    required this.value,
    required this.autocorrect,
    required this.autofillHints,
    required this.autofocus,
    required this.buildCounter,
    required this.style,
    required this.dragStartBehavior,
    required this.enabled,
    required this.enableInteractiveSelection,
    required this.expands,
    required this.keyboardType,
    required this.maxLength,
    required this.maxLengthEnforcement,
    required this.maxLines,
    required this.minLines,
    required this.obscureText,
    required this.onAppPrivateCommand,
    required this.onChanged,
    required this.onEditingComplete,
    required this.onSubmitted,
    required this.onTap,
    required this.readOnly,
    required this.showCursor,
    required this.textCapitalization,
    required this.textDirection,
    required this.textInputAction,
    required this.toolbarOptions,
    required this.name,
  }) : super();

  @override
  _LenraApplicationTextfieldState createState() => _LenraApplicationTextfieldState();
}

class _LenraApplicationTextfieldState extends State<LenraApplicationTextfield> {
  _TimeoutStrategy timeoutStrategy = _AtMostTimeout(duration: Duration(milliseconds: 500));
  final FocusNode _focusNode;
  late final TextEditingController _controller;
  TextInputAction? textInputAction;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value);
    textInputAction = widget.textInputAction;
    if (widget.name != null) {
      context.read<FormProvider?>()?.initFormFieldValue(widget.name!, _controller.text);

      if (widget.textInputAction == null) textInputAction = TextInputAction.next;
    }
    super.initState();
  }

  _LenraApplicationTextfieldState() : _focusNode = FocusNode();

  void handleTimeout(BuildContext context, String value) {
    widget.onChanged!.run(context, (code) => OnChangedEvent(code: code, data: ValueData(value)));
  }

  void onTextFieldSubmitted(BuildContext context, String value) {
    if (widget.onSubmitted != null) {
      EventManager.of(context).sendEvent(OnChangedEvent(code: widget.onSubmitted!.code, data: ValueData(value))).then(
            //implement loading
            (value) => null,
          );
    }
  }

  void onAppPrivateCommandReceived(BuildContext context, String action, Map<String, dynamic> data) {
    if (widget.onAppPrivateCommand != null) {
      EventManager.of(context)
          .sendEvent(OnChangedEvent(code: widget.onAppPrivateCommand!.code, data: ValueData(action)))
          .then(
            //implement loading
            (value) => null,
          );
    }
  }

  void onChanged(String value) {
    if (widget.name != null) {
      context.read<FormProvider?>()?.setFormFieldValue(widget.name!, _controller.text);
    }
    if (widget.onChanged != null) {
      timeoutStrategy.onChanged(context, value, widget.onChanged!.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: widget.autocorrect ?? true,
      autofillHints: widget.autofillHints ?? const <String>[],
      autofocus: widget.autofocus ?? false,
      buildCounter: widget.buildCounter,
      controller: _controller,
      focusNode: _focusNode,
      style: widget.style?.textStyle,
      cursorColor: widget.style?.cursorColor,
      cursorHeight: widget.style?.cursorHeight,
      cursorRadius: widget.style?.cursorRadius,
      cursorWidth: widget.style?.cursorWidth ?? 2.0,
      decoration: widget.style?.decoration ?? const InputDecoration(),
      keyboardAppearance: widget.style?.keyboardAppearance,
      obscuringCharacter: widget.style?.obscuringCharacter ?? '•',
      scrollPadding: widget.style?.scrollPadding ?? const EdgeInsets.all(20.0),
      selectionHeightStyle: widget.style?.selectionHeightStyle ?? BoxHeightStyle.tight,
      selectionWidthStyle: widget.style?.selectionWidthStyle ?? BoxWidthStyle.tight,
      strutStyle: widget.style?.strutStyle,
      textAlign: widget.style?.textAlign ?? TextAlign.start,
      textAlignVertical: widget.style?.textAlignVertical,
      dragStartBehavior: widget.dragStartBehavior ?? DragStartBehavior.start,
      enabled: widget.enabled,
      enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
      expands: widget.expands ?? false,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      obscureText: widget.obscureText ?? false,
      onAppPrivateCommand: widget.onAppPrivateCommand == null
          ? null
          : (action, data) => onAppPrivateCommandReceived(context, action, data),
      onChanged: onChanged,
      onEditingComplete: widget.onEditingComplete == null ? null : () => widget.onEditingComplete,
      onSubmitted: widget.onSubmitted == null ? null : (value) => handleTimeout(context, value),
      onTap: widget.onTap == null ? null : () => widget.onTap,
      readOnly: widget.readOnly ?? false,
      showCursor: widget.showCursor,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      textDirection: widget.textDirection,
      textInputAction: textInputAction,
      // ignore: deprecated_member_use
      toolbarOptions: widget.toolbarOptions,
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
    EventManager.of(context).sendEvent(OnChangedEvent(code: code, data: ValueData(value))).then(
          //implement loading
          (value) => null,
        );
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
    EventManager.of(context)
        .sendEvent(
          OnChangedEvent(code: code, data: ValueData(currentValue)),
        )
        .then(
          //implement loading
          (value) => null,
        );
  }

  @override
  void onChanged(BuildContext context, String value, String code) {
    currentValue = value;
    if (time == null || !time!.isActive) {
      time = Timer(duration, () => _handleTimeout(context, code));
    }
  }
}
