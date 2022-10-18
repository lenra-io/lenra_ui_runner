import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:provider/provider.dart';

class LenraApplicationFormCheckbox extends StatefulWidget {
  final bool? value;
  final bool? tristate;
  final lenra.Listener? onPressed;
  final LenraCheckboxStyle? style;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? autofocus;
  final String name;

  LenraApplicationFormCheckbox({
    required this.value,
    required this.tristate,
    required this.onPressed,
    required this.style,
    required this.materialTapTargetSize,
    required this.autofocus,
    required this.name,
  }) : super();

  @override
  State<LenraApplicationFormCheckbox> createState() => _LenraApplicationFormCheckboxState();
}

class _LenraApplicationFormCheckboxState extends State<LenraApplicationFormCheckbox> {
  @override
  void initState() {
    context.read<FormProvider?>()?.initFormFieldValue(widget.name, widget.value);

    super.initState();
  }

  void onCheck(BuildContext context, bool? value) {
    context.read<FormProvider?>()?.setFormFieldValue(widget.name, value);
    if (widget.onPressed != null) {
      context.read<ChannelModel>().sendEvent(OnChangedEvent(code: widget.onPressed!.code, data: ValueData(value))).then(
            //implement loading
            (value) => null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool tristate = widget.tristate ?? false;
    bool? value = context.select<FormProvider?, bool?>((form) => form?.formFieldValues[widget.name]);

    return LenraCheckbox(
      value: tristate ? value : value ?? widget.value,
      tristate: tristate,
      onPressed: (v) => onCheck(context, v),
      style: widget.style,
      materialTapTargetSize: widget.materialTapTargetSize,
      autofocus: widget.autofocus ?? false,
    );
  }
}
