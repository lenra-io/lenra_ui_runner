import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import '../lenra_component_builder.dart';

// TODO generate this from annotation on LenraText
class LenraTextBuilder extends LenraComponentBuilder<LenraApplicationText> {
  @override
  LenraApplicationText map({
    value,
    textStyle,
  }) {
    return LenraApplicationText(
      value: value,
      textStyle: textStyle,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": String,
      "style": LenraTextStyle,
    };
  }
}

class LenraApplicationText extends StatelessWidget {
  final String value;
  final LenraTextStyle? textStyle;

  LenraApplicationText({
    required this.value,
    required this.textStyle,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraText(
      value,
      style: textStyle ?? LenraTextStyle.bodyText,
    );
  }
}
