library props_parser;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lenra_components/utils/color_parser.dart';

extension ParserExt on Parser {
  // TODO : Generate this from annotation on class Parser
  static Map<String, Function> typeParsers = {
    "String": Parser.parseString,
    "bool": Parser.parseBool,
    "double": Parser.parseDouble,
    "Color": Parser.parseColor,
    "Map<String, dynamic>": Parser.parseListeners,
    "Border": Parser.parseBorder,
    "BorderRadius": Parser.parseBorderRadius,
    "BoxShadow": Parser.parseBoxShadow,
  };
}

class Parser {
  static Color parseColor(String color) {
    return color.parseColor();
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

  static Map<String, dynamic> parseListeners(Map<String, dynamic> listeners) {
    return listeners;
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

  static Map<Symbol, dynamic> parseProps(Map<String, dynamic> props, Map<String, String> propsTypes) {
    Map<Symbol, dynamic> transformedProps = {};

    props.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        String type = propsTypes[key]!;
        if (ParserExt.typeParsers.containsKey(type)) {
          transformedProps[Symbol(key)] = ParserExt.typeParsers[type]!(value);
        }
      }
    });

    return transformedProps;
  }
}
