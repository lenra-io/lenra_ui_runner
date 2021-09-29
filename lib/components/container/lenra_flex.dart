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
      "direction": "String",
      "mainAxisAlignment": "String",
      "crossAxisAlignment": "String",
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
  final String? direction;
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;
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

  static MainAxisAlignment mainAxisAlignmentFromString(String? alignment) {
    switch (alignment) {
      case "start":
        return MainAxisAlignment.start;

      case "end":
        return MainAxisAlignment.end;

      case "center":
        return MainAxisAlignment.center;

      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;

      case "spaceAround":
        return MainAxisAlignment.spaceAround;

      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;

      default:
        return MainAxisAlignment.start;
    }
  }

  static CrossAxisAlignment crossAxisAlignmentFromString(String? alignment) {
    switch (alignment) {
      case "start":
        return CrossAxisAlignment.start;

      case "end":
        return CrossAxisAlignment.end;

      case "center":
        return CrossAxisAlignment.center;

      case "stretch":
        return CrossAxisAlignment.stretch;

      case "baseline":
        return CrossAxisAlignment.baseline;

      default:
        return CrossAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    Axis direction;

    if (this.direction == "col") {
      direction = Axis.vertical;
    } else {
      direction = Axis.horizontal;
    }

    return LenraFlex(
      children: children,
      direction: direction,
      mainAxisAlignment: LenraApplicationFlex.mainAxisAlignmentFromString(mainAxisAlignment),
      crossAxisAlignment: LenraApplicationFlex.crossAxisAlignmentFromString(crossAxisAlignment),
      spacing: spacing ?? 0,
      fillParent: fillParent ?? false,
      scroll: scroll ?? false,
    );
  }
}
