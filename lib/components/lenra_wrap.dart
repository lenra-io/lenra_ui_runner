import 'package:flutter/widgets.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraWrap
class LenraWrapBuilder extends LenraComponentBuilder<LenraApplicationWrap> {
  @override
  LenraApplicationWrap map({
    children,
    direction,
    crossAxisAlignment,
    spacing,
    runSpacing,
    alignment,
    runAlignment,
    textDirection,
    verticalDirection,
  }) {
    return LenraApplicationWrap(
      children: children,
      direction: direction,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      runAlignment: runAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "direction": Axis,
      "crossAxisAlignment": WrapCrossAlignment,
      "spacing": double,
      "runSpacing": double,
      "alignment": WrapAlignment,
      "runAlignment": WrapAlignment,
      "textDirection": TextDirection,
      "verticalDirection": VerticalDirection
    };
  }

  @override
  List<String> get childrenKeys {
    return ["children"];
  }
}

class LenraApplicationWrap extends StatelessWidget {
  final List<Widget> children;
  final Axis? direction;
  final WrapCrossAlignment? crossAxisAlignment;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment? alignment;
  final WrapAlignment? runAlignment;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;

  LenraApplicationWrap({
    required this.children,
    required this.direction,
    required this.crossAxisAlignment,
    required this.spacing,
    required this.runSpacing,
    required this.alignment,
    required this.runAlignment,
    required this.textDirection,
    required this.verticalDirection,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraWrap(
      children: children,
      direction: direction ?? Axis.horizontal,
      crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
      spacing: spacing ?? 0,
      runSpacing: runSpacing ?? 0,
      alignment: alignment ?? WrapAlignment.start,
      runAlignment: runAlignment ?? WrapAlignment.start,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
    );
  }
}
