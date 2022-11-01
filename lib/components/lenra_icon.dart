import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraIcon
class LenraIconBuilder extends LenraComponentBuilder<LenraIcon> {
  @override
  LenraIcon map({
    color,
    value,
    semanticLabel,
    size,
  }) {
    return LenraIcon(
      color: color,
      value: value,
      semanticLabel: semanticLabel,
      size: size,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      'color': Color,
      'value': IconData,
      'semanticLabel': String,
      'size': double,
    };
  }
}

class LenraIcon extends StatelessWidget {
  final Color? color;
  final IconData? value;
  final String? semanticLabel;
  final double? size;

  LenraIcon({
    required this.color,
    required this.value,
    required this.semanticLabel,
    required this.size,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Icon(
      value,
      color: color,
      semanticLabel: semanticLabel,
      size: size ?? 24.0,
    );
  }
}
