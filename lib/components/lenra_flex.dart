import 'package:flutter/widgets.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';

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
    padding,
    horizontalDirection,
    verticalDirection,
    textBaseline,
  }) {
    return LenraApplicationFlex(
      children: children,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      fillParent: fillParent,
      scroll: scroll,
      padding: padding,
      horizontalDirection: horizontalDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "direction": Axis,
      "mainAxisAlignment": MainAxisAlignment,
      "crossAxisAlignment": CrossAxisAlignment,
      "spacing": double,
      "fillParent": bool,
      "scroll": bool,
      "padding": EdgeInsets,
      "horizontalDirection": TextDirection,
      "verticalDirection": VerticalDirection,
      "textBaseline": TextBaseline,
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationFlex extends StatelessWidget {
  final List<Widget> children;
  final Axis? direction;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? spacing;
  final bool? fillParent;
  final bool? scroll;
  final EdgeInsets? padding;
  final TextDirection? horizontalDirection;
  final VerticalDirection? verticalDirection;
  final TextBaseline? textBaseline;

  LenraApplicationFlex({
    required this.children,
    required this.direction,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.spacing,
    required this.fillParent,
    required this.scroll,
    required this.padding,
    required this.horizontalDirection,
    required this.verticalDirection,
    required this.textBaseline,
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
      padding: padding,
      horizontalDirection: horizontalDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      textBaseline: textBaseline,
    );
  }
}
