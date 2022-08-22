import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_components/component/lenra_checkbox.dart';
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
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  void onCheck(BuildContext context, bool? value) {
    setState(() {
      this.value = value;
    });
    context.read<FormProvider?>()?.setFormFieldValue(widget.name, value);
    if (widget.onPressed != null) {
      OnChangedEvent(code: widget.onPressed!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<FormProvider?>()?.setFormFieldValue(widget.name, value);

    return LenraCheckbox(
      value: value,
      tristate: widget.tristate ?? false,
      onPressed: (v) => onCheck(context, v),
      style: widget.style,
      materialTapTargetSize: widget.materialTapTargetSize,
      autofocus: widget.autofocus ?? false,
    );
  }
}
