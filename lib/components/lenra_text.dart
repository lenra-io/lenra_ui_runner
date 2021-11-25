import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import '../lenra_component_builder.dart';

// TODO generate this from annotation on LenraText
class LenraTextBuilder extends LenraComponentBuilder<LenraApplicationText> {
  @override
  LenraApplicationText map({
    value,
    children,
    style,
    locale,
    semanticsLabel,
    spellOut,
  }) {
    return LenraApplicationText(
      value: value,
      children: children,
      style: style,
      locale: locale,
      semanticsLabel: semanticsLabel,
      spellOut: spellOut,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": String,
      "style": TextStyle,
      "locale": Locale,
      "semanticsLabel": String,
      "spellOut": bool,
    };
  }

  @override
  List<String> get childrenKeys {
    return ["children"];
  }
}

class LenraApplicationText extends StatelessWidget {
  final String value;
  final List<LenraText>? children;
  final TextStyle? style;
  final Locale? locale;
  final String? semanticsLabel;
  final bool? spellOut;

  LenraApplicationText({
    required this.value,
    required this.children,
    required this.style,
    required this.locale,
    required this.semanticsLabel,
    required this.spellOut,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraText(
      text: value,
      children: children,
      style: style,
      locale: locale,
      semanticsLabel: semanticsLabel,
      spellOut: spellOut,
    );
  }
}
