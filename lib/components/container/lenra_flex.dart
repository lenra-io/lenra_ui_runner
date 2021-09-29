import 'package:flutter/material.dart';

import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_ui_runner/components/lenra_component.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraFlex
class LenraFlexBuilder extends LenraComponentBuilder<LenraApplicationFlex> {
  @override
  LenraApplicationFlex map({
    children,
    direction,
    mainAxisAlignment,
    crossAxisAlignment,
    spacing,
    fillParent,
    scroll,
  }) {
    return LenraApplicationFlex(
      children: children,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      fillParent: fillParent,
      scroll: scroll,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "direction": "Axis",
      "mainAxisAlignment": "MainAxisAlignment",
      "crossAxisAlignment": "CrossAxisAlignment",
      "spacing": "double",
      "fillParent": "bool",
      "scroll": "bool",
    };
  }

  @override
  List<String> get childrenKeys {
    return ["children"];
  }
}

class LenraApplicationFlex extends StatelessLenraComponent {
  final List<Widget> children;
  final Axis? direction;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? spacing;
  final bool? fillParent;
  final bool? scroll;

  LenraApplicationFlex({
    required this.children,
    required this.direction,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.spacing,
    required this.fillParent,
    required this.scroll,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      children: children,
      direction: direction ?? Axis.horizontal,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      spacing: spacing ?? 0,
      fillParent: fillParent ?? false,
      scroll: scroll ?? false,
    );
  }
}
