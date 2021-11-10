import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraButton
class LenraIconBuilder extends LenraComponentBuilder<LenraApplicationIcon> {
  @override
  LenraApplicationIcon map({
    color,
    icon,
    semanticLabel,
    size,
  }) {
    return LenraApplicationIcon(
      color: color,
      icon: icon,
      semanticLabel: semanticLabel,
      size: size,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      'color': IconData,
      'icon': Icon,
      'semanticLabel': String,
      'size': double,
    };
  }
}

class LenraApplicationIcon extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String? semanticLabel;
  final double? size;

  LenraApplicationIcon({
    required this.color,
    required this.icon,
    required this.semanticLabel,
    required this.size,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      semanticLabel: semanticLabel,
      size: size,
    );
  }
}
