import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import '../lenra_component_builder.dart';

// TODO generate this from annotation on LenraText
class LenraTextBuilder extends LenraComponentBuilder<LenraApplicationText> {
  @override
  LenraApplicationText map({
    text,
    children,
    style,
    locale,
    semanticsLabel,
    spellOut,
  }) {
    return LenraApplicationText(
      text: text,
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
      "text": String,
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
  final String text;
  final List<LenraText>? children;
  final TextStyle? style;
  final Locale? locale;
  final String? semanticsLabel;
  final bool? spellOut;

  LenraApplicationText({
    required this.text,
    required this.children,
    required this.style,
    required this.locale,
    required this.semanticsLabel,
    required this.spellOut,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraText(
      text: text,
      children: children,
      style: style,
      locale: locale,
      semanticsLabel: semanticsLabel,
      spellOut: spellOut,
    );
  }
}
