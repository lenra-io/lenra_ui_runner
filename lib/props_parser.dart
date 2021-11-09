library props_parser;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/utils/icon_util.dart';

extension ParserExt on Parser {
  // TODO : Generate this from annotation on class Parser
  static Map<Type, Function> typeParsers = {
    String: Parser.parseString,
    bool: Parser.parseBool,
    double: Parser.parseDouble,
    Color: Parser.parseColor,
    MainAxisAlignment: Parser.parseMainAxisAlignment,
    CrossAxisAlignment: Parser.parseCrossAxisAlignment,
    Axis: Parser.parseAxis,
    Border: Parser.parseBorder,
    BorderRadius: Parser.parseBorderRadius,
    BoxShadow: Parser.parseBoxShadow,
    EdgeInsets: Parser.parseEdgeInsets,
    Icon: Parser.parseIcon,
    Listener: Parser.parseListener,
    LenraComponentSize: Parser.parseLenraComponentSize,
    int: Parser.parseInteger,
    LenraTextStyle: Parser.parseLenraTextStyle,
    FlexFit: Parser.parseFlexFit,
    TextStyle: Parser.parseTextStyle,
    Locale: Parser.parseLocale,
    List: Parser.parseList,
    BoxConstraints: Parser.parseBoxConstraints,
    BoxDecoration: Parser.parseBoxDecoration,
    BoxShape: Parser.parseBoxShape,
  };
}

class Parser {
  static lenra.Listener parseListener(Map<String, dynamic> listener) {
    return lenra.Listener(listener["code"]);
  }

  static LenraComponentSize parseLenraComponentSize(String size) {
    switch (size) {
      case "small":
        return LenraComponentSize.small;
      case "medium":
        return LenraComponentSize.medium;
      case "large":
        return LenraComponentSize.large;
      default:
        return LenraComponentSize.medium;
    }
  }

  static FlexFit parseFlexFit(String flexFit) {
    switch (flexFit) {
      case "loose":
        return FlexFit.loose;
      case "tight":
        return FlexFit.tight;
      default:
        return FlexFit.loose;
    }
  }

  static Axis parseAxis(String axis) {
    switch (axis) {
      case "col":
        return Axis.vertical;
      case "row":
        return Axis.horizontal;
      default:
        return Axis.horizontal;
    }
  }

  static MainAxisAlignment parseMainAxisAlignment(String alignment) {
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

  static CrossAxisAlignment parseCrossAxisAlignment(String alignment) {
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

  static int parseInteger(int value) {
    return value;
  }

  static Color parseColor(int color) {
    return Color(color);
  }

  static String parseString(dynamic value) {
    return value.toString();
  }

  static bool parseBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    return value.toString().toLowerCase() == "true";
  }

  static double parseDouble(dynamic size) {
    if (size is String) {
      return double.parse(size);
    } else if (size is double) {
      return size;
    }
    return 0;
  }

  static Border parseBorder(Map<String, dynamic> props) {
    return Border(
      top: props.containsKey("top") ? parseBorderSide(props["top"]) : BorderSide.none,
      left: props.containsKey("left") ? parseBorderSide(props["left"]) : BorderSide.none,
      bottom: props.containsKey("bottom") ? parseBorderSide(props["bottom"]) : BorderSide.none,
      right: props.containsKey("right") ? parseBorderSide(props["right"]) : BorderSide.none,
    );
  }

  static BorderSide parseBorderSide(Map<String, dynamic> props) {
    return BorderSide(
      width: props.containsKey("width") ? parseDouble(props["width"]) : 1.0,
      color: props.containsKey("color") ? parseColor(props["color"]) : const Color(4278190080),
    );
  }

  static BorderRadius parseBorderRadius(Map<String, dynamic> props) {
    return BorderRadius.only(
      topLeft: props.containsKey("topLeft") ? parseRadius(props["topLeft"]) : Radius.zero,
      topRight: props.containsKey("topRight") ? parseRadius(props["topRight"]) : Radius.zero,
      bottomLeft: props.containsKey("bottomLeft") ? parseRadius(props["bottomLeft"]) : Radius.zero,
      bottomRight: props.containsKey("bottomRight") ? parseRadius(props["bottomRight"]) : Radius.zero,
    );
  }

  static Radius parseRadius(Map<String, dynamic> props) {
    return Radius.elliptical(
      props.containsKey("x") ? parseDouble(props["x"]) : 0,
      props.containsKey("y") ? parseDouble(props["y"]) : 0,
    );
  }

  static BoxShadow parseBoxShadow(Map<String, dynamic> props) {
    return BoxShadow(
      color: props.containsKey("color") ? parseColor(props["color"]) : const Color(4278190080),
      blurRadius: props.containsKey("blurRadius") ? parseDouble(props["blurRadius"]) : 0.0,
      spreadRadius: props.containsKey("spreadRadius") ? parseDouble(props["spreadRadius"]) : 0.0,
      offset: props.containsKey("offset") ? parseOffset(props["offset"]) : Offset.zero,
    );
  }

  static Offset parseOffset(Map<String, dynamic> props) {
    return Offset(
      props.containsKey("dx") ? parseDouble(props["dx"]) : 0,
      props.containsKey("dy") ? parseDouble(props["dy"]) : 0,
    );
  }

  static EdgeInsets parseEdgeInsets(Map<String, dynamic> props) {
    return EdgeInsets.only(
      left: props.containsKey("left") ? parseDouble(props["left"]) : 0,
      top: props.containsKey("top") ? parseDouble(props["top"]) : 0,
      right: props.containsKey("right") ? parseDouble(props["right"]) : 0,
      bottom: props.containsKey("bottom") ? parseDouble(props["bottom"]) : 0,
    );
  }

  static Icon parseIcon(String value) {
    return Icon(IconUtil.fromString(value));
  }

  static LenraTextStyle parseLenraTextStyle(String value) {
    switch (value) {
      case "headline1":
        return LenraTextStyle.headline1;
      case "headline2":
        return LenraTextStyle.headline2;
      case "headline3":
        return LenraTextStyle.headline3;
      case "headline4":
        return LenraTextStyle.headline4;
      case "headlineBody":
        return LenraTextStyle.headlineBody;
      case "bodyText":
        return LenraTextStyle.bodyText;
      case "blueBodyText":
        return LenraTextStyle.blueBodyText;
      case "subtext":
        return LenraTextStyle.subtext;
      case "disabledBodyText":
        return LenraTextStyle.disabledBodyText;
      case "underDescriptionText":
        return LenraTextStyle.underDescriptionText;
      case "errorText":
        return LenraTextStyle.errorText;
      default:
        return LenraTextStyle.bodyText;
    }
  }

  static TextDirection parseTextDirection(String value) {
    switch (value) {
      case "ltr":
        return TextDirection.ltr;
      case "rtl":
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  static VerticalDirection parseVerticalDirection(String value) {
    switch (value) {
      case "down":
        return VerticalDirection.down;
      case "up":
        return VerticalDirection.up;
      default:
        return VerticalDirection.down;
    }
  }

  static TextBaseline parseTextBaseline(String value) {
    switch (value) {
      case "alphabetic":
        return TextBaseline.alphabetic;
      case "ideographic":
        return TextBaseline.ideographic;
      default:
        return TextBaseline.alphabetic;
    }
  }

  static TextStyle parseTextStyle(Map<String, dynamic> props) {
    return TextStyle(
      color: props.containsKey("color") ? parseColor(props["color"]) : null,
      decoration: props.containsKey("decoration") ? parseTextDecoration(props["decoration"]) : null,
      decorationColor: props.containsKey("decorationColor") ? parseColor(props["decorationColor"]) : null,
      decorationStyle: props.containsKey("decorationStyle") ? parseTextDecorationStyle(props["decorationStyle"]) : null,
      decorationThickness: props.containsKey("decorationThickness") ? parseDouble(props["decorationThickness"]) : null,
      fontFamily: props.containsKey("fontFamily") ? parseString(props["fontFamily"]) : null,
      fontFamilyFallback: props.containsKey("fontFamilyFallback") ? parseList(props["fontFamilyFallback"]) : null,
      fontSize: props.containsKey("fontSize") ? parseDouble(props["fontSize"]) : null,
      fontStyle: props.containsKey("fontStyle") ? parseFontStyle(props["fontStyle"]) : null,
      fontWeight: props.containsKey("fontWeight") ? parseFontWeight(props["fontWeight"]) : null,
      height: props.containsKey("height") ? parseDouble(props["height"]) : null,
      letterSpacing: props.containsKey("letterSpacing") ? parseDouble(props["letterSpacing"]) : null,
      overflow: props.containsKey("overflow") ? parseTextOverflow(props["overflow"]) : null,
      shadows: props.containsKey("shadows") ? parseList(props["shadows"]) : null,
      textBaseline: props.containsKey("textBaseline") ? parseTextBaseline(props["textBaseline"]) : null,
      wordSpacing: props.containsKey("wordSpacing") ? parseDouble(props["wordSpacing"]) : null,
    );
  }

  static TextDecoration parseTextDecoration(String value) {
    switch (value) {
      case "none":
        return TextDecoration.none;
      case "underline":
        return TextDecoration.underline;
      case "overline":
        return TextDecoration.overline;
      case "lineThrough":
        return TextDecoration.lineThrough;
      default:
        return TextDecoration.none;
    }
  }

  static TextDecorationStyle parseTextDecorationStyle(String value) {
    switch (value) {
      case "solid":
        return TextDecorationStyle.solid;
      case "dashed":
        return TextDecorationStyle.dashed;
      case "dotted":
        return TextDecorationStyle.dotted;
      case "double":
        return TextDecorationStyle.double;
      case "wavy":
        return TextDecorationStyle.wavy;
      default:
        return TextDecorationStyle.solid;
    }
  }

  static Locale parseLocale(Map<String, dynamic> props) {
    if (props.containsKey("languageCode") && props.containsKey("countryCode")) {
      return Locale(props["languageCode"], props["countryCode"]);
    } else {
      return Locale('en', 'EN');
    }
  }

  static FontStyle parseFontStyle(String value) {
    switch (value) {
      case "normal":
        return FontStyle.normal;
      case "italic":
        return FontStyle.italic;
      default:
        return FontStyle.normal;
    }
  }

  static FontWeight parseFontWeight(String value) {
    switch (value) {
      case "normal":
        return FontWeight.normal;
      case "bold":
        return FontWeight.bold;
      case "w100":
        return FontWeight.w100;
      case "w200":
        return FontWeight.w200;
      case "w300":
        return FontWeight.w300;
      case "w400":
        return FontWeight.w400;
      case "w500":
        return FontWeight.w500;
      case "w600":
        return FontWeight.w600;
      case "w700":
        return FontWeight.w700;
      case "w800":
        return FontWeight.w800;
      case "w900":
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  static TextOverflow parseTextOverflow(String value) {
    switch (value) {
      case "visible":
        return TextOverflow.visible;
      case "clip":
        return TextOverflow.clip;
      case "ellipsis":
        return TextOverflow.ellipsis;
      case "fade":
        return TextOverflow.fade;
      default:
        return TextOverflow.visible;
    }
  }

  static List<T> parseList<T>(List<T> list) {
    return list;
  }

  static BoxConstraints parseBoxConstraints(Map<String, dynamic> props) {
    return BoxConstraints(
      minWidth: props.containsKey("minWidth") ? parseDouble(props["minWidth"]) : 0,
      maxWidth: props.containsKey("maxWidth") ? parseDouble(props["maxWidth"]) : -1,
      minHeight: props.containsKey("minHeight") ? parseDouble(props["minHeight"]) : 0,
      maxHeight: props.containsKey("maxHeight") ? parseDouble(props["maxHeight"]) : -1,
    );
  }

  static BoxDecoration parseBoxDecoration(Map<String, dynamic> props) {
    return BoxDecoration(
      border: props.containsKey("border") ? parseBorder(props["border"]) : null,
      borderRadius: props.containsKey("borderRadius") ? parseBorderRadius(props["borderRadius"]) : null,
      boxShadow: props.containsKey("boxShadow") ? [parseBoxShadow(props["boxShadow"])] : null,
      color: props.containsKey("color") ? parseColor(props["color"]) : null,
      shape: props.containsKey("shape") ? parseBoxShape(props["shape"]) : BoxShape.rectangle,
    );
  }

  static BoxShape parseBoxShape(String shape) {
    switch (shape) {
      case "rectangle":
        return BoxShape.rectangle;
      case "circle":
        return BoxShape.circle;
      default:
        return BoxShape.rectangle;
    }
  }

  static Map<Symbol, dynamic> parseProps(Map<String, dynamic> props, Map<String, Type> propsTypes) {
    Map<Symbol, dynamic> transformedProps = {};

    props.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        Type type = propsTypes[key]!;
        if (ParserExt.typeParsers.containsKey(type)) {
          transformedProps[Symbol(key)] = ParserExt.typeParsers[type]!(value);
        }
      }
    });

    return transformedProps;
  }
}
