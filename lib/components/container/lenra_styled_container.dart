import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';

// TODO : generate this from annotation on LenraApplicationStyledContainer
class LenraStyledContainerBuilder extends LenraComponentBuilder<LenraApplicationStyledContainer> {
  @override
  LenraApplicationStyledContainer map({child, backgroundColor}) {
    return LenraApplicationStyledContainer(child: child, backgroundColor: backgroundColor);
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "child": "Widget",
      "backgroundColor": "Color",
      "borderWidth": "double",
      "borderColor": "Color",
      "borderRadius": "double",
    };
  }
}

class LenraApplicationStyledContainer extends StatelessLenraComponent {
  final Widget child;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final double? borderRadius;

  LenraApplicationStyledContainer({
    required this.child,
    required this.backgroundColor,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Border? border;

    if (borderWidth != null || borderColor != null) {
      border = Border.all(width: borderWidth ?? 1.0, color: borderColor ?? const Color(4278190080));
    }

    return LenraStyledContainer(
      border: border,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      color: backgroundColor,
      child: child,
    );
  }
}
