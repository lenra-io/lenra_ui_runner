import 'package:flutter/widgets.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';

// TODO : generate this from annotation on LenraWrap
class LenraWrapBuilder extends LenraComponentBuilder<LenraApplicationWrap> {
  @override
  LenraApplicationWrap map({
    children,
    direction,
    spacing,
    runSpacing,
    crossAxisAlignment,
    alignment,
    runAlignment,
    horizontalDirection,
    verticalDirection,
  }) {
    return LenraApplicationWrap(
      children: children,
      direction: direction,
      spacing: spacing,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      alignment: alignment,
      runAlignment: runAlignment,
      horizontalDirection: horizontalDirection,
      verticalDirection: verticalDirection,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "direction": Axis,
      "spacing": double,
      "runSpacing": double,
      "crossAxisAlignment": WrapCrossAlignment,
      "alignment": WrapAlignment,
      "runAlignment": WrapAlignment,
      "horizontalDirection": TextDirection,
      "verticalDirection": VerticalDirection,
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationWrap extends StatelessWidget {
  final List<Widget> children;
  final Axis? direction;
  final double? spacing;
  final double? runSpacing;
  final WrapCrossAlignment? crossAxisAlignment;
  final WrapAlignment? alignment;
  final WrapAlignment? runAlignment;
  final TextDirection? horizontalDirection;
  final VerticalDirection? verticalDirection;

  LenraApplicationWrap({
    required this.children,
    required this.direction,
    required this.spacing,
    required this.runSpacing,
    required this.crossAxisAlignment,
    required this.alignment,
    required this.runAlignment,
    required this.horizontalDirection,
    required this.verticalDirection,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraWrap(
      children: children,
      direction: direction ?? Axis.horizontal,
      spacing: spacing ?? 0,
      runSpacing: runSpacing ?? 0,
      crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
      alignment: alignment ?? WrapAlignment.start,
      runAlignment: runAlignment ?? WrapAlignment.start,
      horizontalDirection: horizontalDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
    );
  }
}
