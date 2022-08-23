import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/theme/lenra_toggle_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraToggle
class LenraToggleBuilder extends LenraComponentBuilder<LenraApplicationToggle> {
  @override
  LenraApplicationToggle map({
    value,
    onPressed,
    style,
    splashRadius,
    autofocus,
    dragStartBehavior,
    name,
    disabled = false,
  }) {
    return LenraApplicationToggle(
      value: value,
      onPressed: onPressed,
      style: style,
      splashRadius: splashRadius,
      autofocus: autofocus,
      dragStartBehavior: dragStartBehavior,
      name: name,
      disabled: disabled, 
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": bool,
      "onPressed": lenra.Listener,
      "style": LenraToggleStyle,
      "splashRadius": double,
      "autofocus": bool,
      "dragStartBehavior": DragStartBehavior,
      "name": String,
      "disabled": bool,
    };
  }
}

class LenraApplicationToggle extends StatelessWidget {
  final bool value;
  final lenra.Listener? onPressed;
  final LenraToggleStyle? style;
  final double? splashRadius;
  final bool? autofocus;
  final DragStartBehavior? dragStartBehavior;
  final String? name;
  final bool disabled;

  LenraApplicationToggle({
    required this.value,
    required this.onPressed,
    required this.style,
    required this.splashRadius,
    required this.autofocus,
    required this.dragStartBehavior,
    required this.name,
    required this.disabled,
  }) : super();

  void onTogglePressed(BuildContext context, bool value) {
    if (name != null) {
      context.read<FormProvider?>()?.setFormFieldValue(name!, value);
    }
    if (onPressed != null) {
      OnChangedEvent(code: onPressed!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? formValue;

    if (name != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<FormProvider?>()?.setFormFieldValue(name!, value);
      });
      formValue = context.select<FormProvider?, bool?>((form) => form?.formFieldValues[name]);
    }

    return LenraToggle(
      value: formValue ?? value,
      onPressed: disabled ? null : (value) => onTogglePressed(context, value),
      style: style,
      splashRadius: splashRadius,
      autofocus: autofocus ?? false,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
    );
  }
}
