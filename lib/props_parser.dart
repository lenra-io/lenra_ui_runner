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
    "MainAxisAlignment": Parser.parseMainAxisAlignment,
    "CrossAxisAlignment": Parser.parseCrossAxisAlignment,
    "Axis": Parser.parseAxis,
  };
}

class Parser {
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

  static Map<Symbol, dynamic> parseProps(
      Map<String, dynamic> props, Map<String, String> propsTypes) {
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
