library props_parser;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';
import 'package:lenra_components/theme/lenra_slider_style.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_components/theme/lenra_toggle_style.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/lenra_text.dart';
import 'package:lenra_ui_runner/components/lenra_textfield.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/utils/lenra_text_field_style.dart';
import 'package:lenra_ui_runner/utils/icon_util.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';
import 'package:lenra_ui_runner/components/lenra_button.dart';
import 'package:lenra_ui_runner/components/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/components/lenra_overlay_entry.dart';
import 'package:lenra_ui_runner/components/lenra_radio.dart';
import 'package:lenra_ui_runner/components/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/components/lenra_flexible.dart';
import 'package:lenra_ui_runner/components/lenra_container.dart';
import 'package:lenra_ui_runner/components/lenra_stack.dart';
import 'package:lenra_ui_runner/components/lenra_slider.dart';
import 'package:lenra_ui_runner/components/lenra_actionable.dart';
import 'package:lenra_ui_runner/components/lenra_menu.dart';
import 'package:lenra_ui_runner/components/lenra_menu_item.dart';
import 'package:lenra_ui_runner/components/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/lenra_status_sticker.dart';
import 'package:lenra_ui_runner/components/lenra_flex.dart';
import 'package:lenra_ui_runner/components/lenra_wrap.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

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
    IconData: Parser.parseIconData,
    lenra.Listener: Parser.parseListener,
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
    WrapCrossAlignment: Parser.parseWrapCrossAlignment,
    WrapAlignment: Parser.parseWrapAlignment,
    VerticalDirection: Parser.parseVerticalDirection,
    TextDirection: Parser.parseTextDirection,
    MaterialTapTargetSize: Parser.parseMaterialTapTargetSize,
    LenraRadioStyle: Parser.parseLenraRadioStyle,
    VisualDensity: Parser.parseVisualDensity,
    DragStartBehavior: Parser.parseDragStartBehavior,
    LenraToggleStyle: Parser.parseLenraToggleStyle,
    Alignment: Parser.parseAlignment,
    AlignmentGeometry: Parser.parseAlignment,
    StackFit: Parser.parseStackFit,
    LenraSliderStyle: Parser.parseLenraSliderStyle,
    ChildrenWidgets: Parser.parseChildrenWidgets,
    Widget: Parser.parseWidget,
    LenraTextFieldStyle: Parser.parseLenraTextFieldStyle,
    TextInputType: Parser.parseTextInputType,
    MaxLengthEnforcement: Parser.parseMaxLengthEnforcement,
    TextCapitalization: Parser.parseTextCapitalization,
    TextInputAction: Parser.parseTextInputAction,
    // ignore: deprecated_member_use
    ToolbarOptions: Parser.parseToolbarOptions,
    Rect: Parser.parseRect,
    FilterQuality: Parser.parseFilterQuality,
    BoxFit: Parser.parseBoxFit,
    ImageRepeat: Parser.parseImageRepeat,
    AutofillHints: Parser.parseAutofillHints,
    TextAlign: Parser.parseTextAlign,
  };
}

class Parser {
  static final Map<String, LenraComponentBuilder> componentsMapping = {
    'text': LenraTextBuilder(),
    'textfield': LenraTextfieldBuilder(),
    'button': LenraButtonBuilder(),
    'checkbox': LenraCheckboxBuilder(),
    'image': LenraImageBuilder(),
    'radio': LenraRadioBuilder(),
    'menu': LenraMenuBuilder(),
    'menuItem': LenraMenuItemBuilder(),
    'toggle': LenraToggleBuilder(),
    'statusSticker': LenraStatusStickerBuilder(),
    'flex': LenraFlexBuilder(),
    'container': LenraContainerBuilder(),
    'actionable': LenraActionableBuilder(),
    'dropdownButton': LenraDropdownButtonBuilder(),
    'flexible': LenraFlexibleBuilder(),
    'wrap': LenraWrapBuilder(),
    'stack': LenraStackBuilder(),
    'slider': LenraSliderBuilder(),
    'overlayEntry': LenraOverlayEntryBuilder(),
    'icon': LenraIconBuilder(),
    'form': LenraFormBuilder(),
  };

  static String? getType(Map<String, dynamic> json) {
    return json['type'] as String?;
  }

  static LenraComponentBuilder? getComponentBuilder(String type) {
    if (componentsMapping.containsKey(type)) {
      return componentsMapping[type];
    }

    return null;
  }

  static Function? getParser(Type t) {
    return ParserExt.typeParsers[t];
  }

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
        return FlexFit.tight;
    }
  }

  static Axis parseAxis(String axis) {
    switch (axis) {
      case "vertical":
        return Axis.vertical;
      case "horizontal":
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

  static bool? parseBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value == null) {
      return value;
    }
    return value.toString().toLowerCase() == "true";
  }

  static double parseDouble(dynamic size) {
    if (size is String) {
      return double.parse(size);
    } else if (size is double) {
      return size;
    } else if (size is int) {
      return size.toDouble();
    }
    return 0;
  }

  static double parseInfinity(double value) {
    if (value == -1) {
      return double.infinity;
    } else {
      return value;
    }
  }

  static Border parseBorder(Map<String, dynamic> props) {
    return Border(
      top: props.containsKey("top") ? parseBorderSide(props["top"]) : BorderSide.none,
      left: props.containsKey("left") ? parseBorderSide(props["left"]) : BorderSide.none,
      bottom: props.containsKey("bottom") ? parseBorderSide(props["bottom"]) : BorderSide.none,
      right: props.containsKey("right") ? parseBorderSide(props["right"]) : BorderSide.none,
    );
  }

  static LenraRadioStyle parseLenraRadioStyle(Map<String, dynamic> props) {
    return LenraRadioStyle(
      activeColor: props.containsKey("activeColor") ? parseColor(props["activeColor"]) : null,
      focusColor: props.containsKey("focusColor") ? parseColor(props["focusColor"]) : null,
      hoverColor: props.containsKey("hoverColor") ? parseColor(props["hoverColor"]) : null,
      unselectedColor: props.containsKey("unselectedColor") ? parseColor(props["unselectedColor"]) : null,
      splashRadius: props.containsKey("splashRadius") ? parseDouble(props["splashRadius"]) : null,
      visualDensity: props.containsKey("visualDensity") ? parseVisualDensity(props["visualDensity"]) : null,
    );
  }

  static VisualDensity parseVisualDensity(String value) {
    switch (value) {
      case "comfortable":
        return VisualDensity.comfortable;
      case "compact":
        return VisualDensity.compact;
      case "standard":
        return VisualDensity.standard;
      default:
        return VisualDensity.comfortable;
    }
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

  static DragStartBehavior parseDragStartBehavior(String value) {
    switch (value) {
      case "down":
        return DragStartBehavior.down;
      case "start":
        return DragStartBehavior.start;
      default:
        return DragStartBehavior.start;
    }
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

  static IconData? parseIconData(String value) {
    return IconUtil.fromString(value);
  }

  static LenraToggleStyle parseLenraToggleStyle(Map<String, dynamic> props) {
    return LenraToggleStyle(
      activeTrackColor: props.containsKey("activeTrackColor") ? parseColor(props["activeTrackColor"]) : null,
      inactiveThumbColor: props.containsKey("inactiveThumbColor") ? parseColor(props["inactiveThumbColor"]) : null,
      hoverColor: props.containsKey("hoverColor") ? parseColor(props["hoverColor"]) : null,
      focusColor: props.containsKey("focusColor") ? parseColor(props["focusColor"]) : null,
      materialTapTargetSize: props.containsKey("materialTapTargetSize")
          ? parseMaterialTapTargeSize(props["materialTapTargetSize"])
          : MaterialTapTargetSize.padded,
    );
  }

  static MaterialTapTargetSize parseMaterialTapTargeSize(String size) {
    switch (size) {
      case "padded":
        return MaterialTapTargetSize.padded;
      case "shrinkWrap":
        return MaterialTapTargetSize.shrinkWrap;
      default:
        return MaterialTapTargetSize.padded;
    }
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
      minWidth: props.containsKey("minWidth") ? parseInfinity(parseDouble(props["minWidth"])) : 0,
      maxWidth: props.containsKey("maxWidth") ? parseInfinity(parseDouble(props["maxWidth"])) : double.infinity,
      minHeight: props.containsKey("minHeight") ? parseInfinity(parseDouble(props["minHeight"])) : 0,
      maxHeight: props.containsKey("maxHeight") ? parseInfinity(parseDouble(props["maxHeight"])) : double.infinity,
    );
  }

  static BoxDecoration parseBoxDecoration(Map<String, dynamic> props) {
    return BoxDecoration(
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

  static WrapCrossAlignment parseWrapCrossAlignment(String value) {
    switch (value) {
      case "start":
        return WrapCrossAlignment.start;
      case " center":
        return WrapCrossAlignment.center;
      case "end":
        return WrapCrossAlignment.end;
      default:
        return WrapCrossAlignment.start;
    }
  }

  static WrapAlignment parseWrapAlignment(String value) {
    switch (value) {
      case "start":
        return WrapAlignment.start;
      case "end":
        return WrapAlignment.end;
      case "center":
        return WrapAlignment.center;
      case "spaceBetween":
        return WrapAlignment.spaceBetween;
      case "spaceAround":
        return WrapAlignment.spaceAround;
      case "spaceEvenly":
        return WrapAlignment.spaceEvenly;
      default:
        return WrapAlignment.start;
    }
  }

  static Alignment parseAlignment(String value) {
    switch (value) {
      case "center":
        return Alignment.center;
      case "bottomCenter":
        return Alignment.bottomCenter;
      case "bottomLeft":
        return Alignment.bottomLeft;
      case "bottomRight":
        return Alignment.bottomRight;
      case "centerLeft":
        return Alignment.centerLeft;
      case "centerRight":
        return Alignment.centerRight;
      case "topCenter":
        return Alignment.topCenter;
      case "topLeft":
        return Alignment.topLeft;
      case "topRight":
        return Alignment.topRight;
      default:
        return Alignment.center;
    }
  }

  static StackFit parseStackFit(String value) {
    switch (value) {
      case "loose":
        return StackFit.loose;
      case "expand":
        return StackFit.expand;
      case "passthrough":
        return StackFit.passthrough;
      default:
        return StackFit.loose;
    }
  }

  static LenraSliderStyle parseLenraSliderStyle(Map<String, dynamic> props) {
    return LenraSliderStyle(
      activeColor: props.containsKey("activeColor") ? parseColor(props["activeColor"]) : null,
      inactiveColor: props.containsKey("inactiveColor") ? parseColor(props["inactiveColor"]) : null,
      thumbColor: props.containsKey("thumbColor") ? parseColor(props["thumbColor"]) : null,
    );
  }

  static List<Widget> parseChildrenWidgets(List<dynamic> props) {
    List<Widget> result = [];

    for (var element in props) {
      result.add(parseWidget(element));
    }

    return result;
  }

  static Widget parseWidget(Map<String, dynamic> props) {
    return LenraWidget.parseJson(props);
  }

  static FilterQuality parseFilterQuality(String value) {
    switch (value) {
      case "low":
        return FilterQuality.low;
      case "medium":
        return FilterQuality.medium;
      case "high":
        return FilterQuality.high;
      case "none":
        return FilterQuality.none;
      default:
        return FilterQuality.low;
    }
  }

  static Rect parseRect(Map<String, dynamic> props) {
    return Rect.fromLTWH(
      props.containsKey("left") ? parseDouble(props["left"]) : 0,
      props.containsKey("top") ? parseDouble(props["top"]) : 0,
      props.containsKey("width") ? parseDouble(props["width"]) : 0,
      props.containsKey("height") ? parseDouble(props["height"]) : 0,
    );
  }

  static BoxFit parseBoxFit(String value) {
    switch (value) {
      case "contain":
        return BoxFit.contain;
      case "cover":
        return BoxFit.cover;
      case "fill":
        return BoxFit.fill;
      case "fitHeight":
        return BoxFit.fitHeight;
      case "fitWidth":
        return BoxFit.fitWidth;
      case "none":
        return BoxFit.none;
      case "scaleDown":
        return BoxFit.scaleDown;
      default:
        return BoxFit.contain;
    }
  }

  static ImageRepeat parseImageRepeat(String value) {
    switch (value) {
      case "noRepeat":
        return ImageRepeat.noRepeat;
      case "repeat":
        return ImageRepeat.repeat;
      case "repeatX":
        return ImageRepeat.repeatX;
      case "repeatY":
        return ImageRepeat.repeatY;
      default:
        return ImageRepeat.noRepeat;
    }
  }

  static Iterable<String>? parseAutofillHints(List<dynamic> values) {
    return values.cast<String>();
  }

  static LenraTextFieldStyle parseLenraTextFieldStyle(Map<String, dynamic> props) {
    return LenraTextFieldStyle(
      cursorColor: props.containsKey("cursorColor") ? parseColor(props["cursorColor"]) : null,
      cursorHeight: props.containsKey("cursorHeight") ? parseDouble(props["cursorHeight"]) : null,
      cursorRadius: props.containsKey("cursorRadius") ? parseRadius(props["cursorRadius"]) : null,
      cursorWidth: props.containsKey("cursorWidth") ? parseDouble(props["cursorWidth"]) : 2.0,
      decoration: props.containsKey("decoration") ? parseInputDecoration(props["decoration"]) : const InputDecoration(),
      keyboardAppearance:
          props.containsKey("keyboardAppearance") ? parseKeyboardAppearance(props["keyboardAppearance"]) : null,
      obscuringCharacter: props.containsKey("obscuringCharacter") ? parseString(props["obscuringCharacter"]) : '•',
      scrollPadding:
          props.containsKey("scrollPadding") ? parseEdgeInsets(props["scrollPadding"]) : const EdgeInsets.all(20.0),
      selectionHeightStyle: props.containsKey("selectionHeightStyle")
          ? parseBoxHeightStyle(props["selectionHeightStyle"])
          : ui.BoxHeightStyle.tight,
      selectionWidthStyle: props.containsKey("selectionWidthStyle")
          ? parseBoxWidthStyle(props["selectionWidthStyle"])
          : ui.BoxWidthStyle.tight,
      strutStyle: props.containsKey("strutStyle") ? parseStrutStyle(props["strutStyle"]) : null,
      textStyle: props.containsKey("textStyle") ? parseTextStyle(props["textStyle"]) : null,
      textAlign: props.containsKey("textAlign") ? parseTextAlign(props["textAlign"]) : TextAlign.start,
      textAlignVertical:
          props.containsKey("textAlignVertical") ? parseTextAlignVertical(props["textAlignVertical"]) : null,
    );
  }

  static InputDecoration parseInputDecoration(Map<String, dynamic> props) {
    return InputDecoration(
      icon: props.containsKey("icon") ? parseWidget(props["icon"]) : null,
      iconColor: props.containsKey("iconColor") ? parseColor(props["iconColor"]) : null,
      label: props.containsKey("label") ? parseWidget(props["label"]) : null,
      labelText: props.containsKey("labelText") ? parseString(props["labelText"]) : null,
      labelStyle: props.containsKey("labelStyle") ? parseTextStyle(props["labelStyle"]) : null,
      floatingLabelStyle: props.containsKey("floatingLabelStyle") ? parseTextStyle(props["floatingLabelStyle"]) : null,
      helperText: props.containsKey("helperText") ? parseString(props["helperText"]) : null,
      helperStyle: props.containsKey("helperStyle") ? parseTextStyle(props["helperStyle"]) : null,
      helperMaxLines: props.containsKey("helperMaxLines") ? parseInteger(props["helperMaxLines"]) : null,
      hintText: props.containsKey("hintText") ? parseString(props["hintText"]) : null,
      hintStyle: props.containsKey("hintStyle") ? parseTextStyle(props["hintStyle"]) : null,
      hintTextDirection: props.containsKey("hintTextDirection") ? parseTextDirection(props["hintTextDirection"]) : null,
      hintMaxLines: props.containsKey("hintMaxLines") ? parseInteger(props["hintMaxLines"]) : null,
      errorText: props.containsKey("errorText") ? parseString(props["errorText"]) : null,
      errorStyle: props.containsKey("errorStyle") ? parseTextStyle(props["errorStyle"]) : null,
      errorMaxLines: props.containsKey("errorMaxLines") ? parseInteger(props["errorMaxLines"]) : null,
      floatingLabelBehavior: props.containsKey("floatingLabelBehavior")
          ? parseFloatingLabelBehavior(props["floatingLabelBehavior"])
          : null,
      isCollapsed: props.containsKey("isCollapsed") ? parseBool(props["isCollapsed"]) ?? false : false,
      isDense: props.containsKey("isDense") ? parseBool(props["isDense"]) : null,
      contentPadding: props.containsKey("contentPadding") ? parseEdgeInsets(props["contentPadding"]) : null,
      prefixIcon: props.containsKey("prefixIcon") ? parseWidget(props["prefixIcon"]) : null,
      prefixIconConstraints:
          props.containsKey("prefixIconConstraints") ? parseBoxConstraints(props["prefixIconConstraints"]) : null,
      prefix: props.containsKey("prefix") ? parseWidget(props["prefix"]) : null,
      prefixText: props.containsKey("prefixText") ? parseString(props["prefixText"]) : null,
      prefixStyle: props.containsKey("prefixStyle") ? parseTextStyle(props["prefixStyle"]) : null,
      prefixIconColor: props.containsKey("prefixIconColor") ? parseColor(props["prefixIconColor"]) : null,
      suffixIcon: props.containsKey("suffixIcon") ? parseWidget(props["suffixIcon"]) : null,
      suffix: props.containsKey("suffix") ? parseWidget(props["suffix"]) : null,
      suffixText: props.containsKey("suffixText") ? parseString(props["suffixText"]) : null,
      suffixStyle: props.containsKey("suffixStyle") ? parseTextStyle(props["suffixStyle"]) : null,
      suffixIconColor: props.containsKey("suffixIconColor") ? parseColor(props["suffixIconColor"]) : null,
      suffixIconConstraints:
          props.containsKey("suffixIconConstraints") ? parseBoxConstraints(props["suffixIconConstraints"]) : null,
      counter: props.containsKey("counter") ? parseWidget(props["counter"]) : null,
      counterText: props.containsKey("counterText") ? parseString(props["counterText"]) : null,
      counterStyle: props.containsKey("counterStyle") ? parseTextStyle(props["counterStyle"]) : null,
      filled: props.containsKey("filled") ? parseBool(props["filled"]) : null,
      fillColor: props.containsKey("fillColor") ? parseColor(props["fillColor"]) : null,
      focusColor: props.containsKey("focusColor") ? parseColor(props["focusColor"]) : null,
      hoverColor: props.containsKey("hoverColor") ? parseColor(props["hoverColor"]) : null,
      errorBorder: props.containsKey("errorBorder") ? parseInputBorder(props["errorBorder"]) : null,
      focusedBorder: props.containsKey("focusedBorder") ? parseInputBorder(props["focusedBorder"]) : null,
      focusedErrorBorder:
          props.containsKey("focusedErrorBorder") ? parseInputBorder(props["focusedErrorBorder"]) : null,
      disabledBorder: props.containsKey("disabledBorder") ? parseInputBorder(props["disabledBorder"]) : null,
      enabledBorder: props.containsKey("enabledBorder") ? parseInputBorder(props["enabledBorder"]) : null,
      border: props.containsKey("border") ? parseInputBorder(props["border"]) : null,
      enabled: props.containsKey("enabled") ? parseBool(props["enabled"]) ?? true : true,
      semanticCounterText: props.containsKey("semanticCounterText") ? parseString(props["semanticCounterText"]) : null,
      alignLabelWithHint: props.containsKey("alignLabelWithHint") ? parseBool(props["alignLabelWithHint"]) : null,
      constraints: props.containsKey("constraints") ? parseBoxConstraints(props["constraints"]) : null,
    );
  }

  static InputBorder parseInputBorder(Map<String, dynamic> props) {
    String? inputBorderType = props.containsKey("type") ? parseString(props["type"]) : null;
    BorderRadius? borderRadius = props.containsKey("borderRadius") ? parseBorderRadius(props["borderRadius"]) : null;
    BorderSide? borderSide = props.containsKey("borderSide") ? parseBorderSide(props["borderSide"]) : null;

    switch (inputBorderType) {
      case "underline":
        return UnderlineInputBorder(
          borderRadius:
              borderRadius ?? const BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          borderSide: borderSide ?? const BorderSide(),
        );
      case "outline":
        return OutlineInputBorder(
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
          borderSide: borderSide ?? const BorderSide(),
        );
    }

    return UnderlineInputBorder();
  }

  static Brightness parseKeyboardAppearance(String value) {
    switch (value) {
      case "light":
        return Brightness.light;
      case "dark":
        return Brightness.dark;
      default:
        return Brightness.light;
    }
  }

  static ui.BoxHeightStyle parseBoxHeightStyle(String value) {
    switch (value) {
      case "includeLineSpacingBottom":
        return ui.BoxHeightStyle.includeLineSpacingBottom;
      case "includeLineSpacingMiddle":
        return ui.BoxHeightStyle.includeLineSpacingMiddle;
      case "includeLineSpacingTop":
        return ui.BoxHeightStyle.includeLineSpacingTop;
      case "max":
        return ui.BoxHeightStyle.max;
      case "strut":
        return ui.BoxHeightStyle.strut;
      case "tight":
        return ui.BoxHeightStyle.tight;
      default:
        return ui.BoxHeightStyle.tight;
    }
  }

  static ui.BoxWidthStyle parseBoxWidthStyle(String value) {
    switch (value) {
      case "max":
        return ui.BoxWidthStyle.max;
      case "tight":
        return ui.BoxWidthStyle.tight;
      default:
        return ui.BoxWidthStyle.tight;
    }
  }

  static StrutStyle parseStrutStyle(Map<String, dynamic> props) {
    return StrutStyle(
      fontFamily: props.containsKey("fontFamily") ? parseString(props["fontFamily"]) : null,
      fontFamilyFallback: props.containsKey("fontFamilyFallback") ? parseList(props["fontFamilyFallback"]) : null,
      fontSize: props.containsKey("fontSize") ? parseDouble(props["fontSize"]) : null,
      height: props.containsKey("height") ? parseDouble(props["height"]) : null,
      leadingDistribution:
          props.containsKey("leadingDistribution") ? parseTextLeadingDistribution(props["leadingDistribution"]) : null,
      leading: props.containsKey("leading") ? parseDouble(props["leading"]) : null,
      fontWeight: props.containsKey("fontWeight") ? parseFontWeight(props["fontWeight"]) : null,
      fontStyle: props.containsKey("fontStyle") ? parseFontStyle(props["fontStyle"]) : null,
      forceStrutHeight: props.containsKey("forceStrutHeight") ? parseBool(props["forceStrutHeight"]) : null,
      debugLabel: props.containsKey("debugLabel") ? parseString(props["debugLabel"]) : null,
      package: props.containsKey("package") ? parseString(props["package"]) : null,
    );
  }

  static TextLeadingDistribution parseTextLeadingDistribution(String value) {
    switch (value) {
      case "even":
        return TextLeadingDistribution.even;
      case "proportional":
        return TextLeadingDistribution.proportional;
      default:
        return TextLeadingDistribution.even;
    }
  }

  static TextAlign parseTextAlign(String value) {
    switch (value) {
      case "center":
        return TextAlign.center;
      case "end":
        return TextAlign.end;
      case "justify":
        return TextAlign.justify;
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      case "start":
        return TextAlign.start;
      default:
        return TextAlign.start;
    }
  }

  static TextAlignVertical parseTextAlignVertical(String value) {
    switch (value) {
      case "bottom":
        return TextAlignVertical.bottom;
      case "center":
        return TextAlignVertical.center;
      case "top":
        return TextAlignVertical.top;
      default:
        return TextAlignVertical.center;
    }
  }

  static FloatingLabelBehavior parseFloatingLabelBehavior(String value) {
    switch (value) {
      case "auto":
        return FloatingLabelBehavior.auto;
      case "always":
        return FloatingLabelBehavior.always;
      case "never":
        return FloatingLabelBehavior.never;
      default:
        return FloatingLabelBehavior.auto;
    }
  }

  static TextInputType parseTextInputType(String value) {
    switch (value) {
      case "text":
        return TextInputType.text;
      case "multiline":
        return TextInputType.multiline;
      case "number":
        return TextInputType.number;
      case "phone":
        return TextInputType.phone;
      case "datetime":
        return TextInputType.datetime;
      case "emailAddress":
        return TextInputType.emailAddress;
      case "url":
        return TextInputType.url;
      case "visiblePassword":
        return TextInputType.visiblePassword;
      case "name":
        return TextInputType.name;
      case "streetAddress":
        return TextInputType.streetAddress;
      case "none":
        return TextInputType.none;
      default:
        return TextInputType.text;
    }
  }

  static MaxLengthEnforcement parseMaxLengthEnforcement(String value) {
    switch (value) {
      case "none":
        return MaxLengthEnforcement.none;
      case "enforced":
        return MaxLengthEnforcement.enforced;
      case "truncateAfterCompositionEnds":
        return MaxLengthEnforcement.truncateAfterCompositionEnds;
      default:
        return MaxLengthEnforcement.none;
    }
  }

  static TextCapitalization parseTextCapitalization(String value) {
    switch (value) {
      case "none":
        return TextCapitalization.none;
      case "characters":
        return TextCapitalization.characters;
      case "sentences":
        return TextCapitalization.sentences;
      case "words":
        return TextCapitalization.words;
      default:
        return TextCapitalization.none;
    }
  }

  static TextInputAction parseTextInputAction(String value) {
    switch (value) {
      case "none":
        return TextInputAction.none;
      case "unspecified":
        return TextInputAction.unspecified;
      case "done":
        return TextInputAction.done;
      case "go":
        return TextInputAction.go;
      case "next":
        return TextInputAction.next;
      case "previous":
        return TextInputAction.previous;
      case "search":
        return TextInputAction.search;
      case "send":
        return TextInputAction.send;
      case "continueAction":
        return TextInputAction.continueAction;
      case "join":
        return TextInputAction.join;
      case "route":
        return TextInputAction.route;
      case "emergencyCall":
        return TextInputAction.emergencyCall;
      case "newline":
        return TextInputAction.newline;
      default:
        return TextInputAction.none;
    }
  }

  // ignore: deprecated_member_use
  static ToolbarOptions parseToolbarOptions(Map<String, dynamic> props) {
    // ignore: deprecated_member_use
    return ToolbarOptions(
      copy: props.containsKey("copy") ? parseBool(props["copy"]) ?? false : false,
      cut: props.containsKey("cut") ? parseBool(props["cut"]) ?? false : false,
      paste: props.containsKey("paste") ? parseBool(props["paste"]) ?? false : false,
      selectAll: props.containsKey("selectAll") ? parseBool(props["selectAll"]) ?? false : false,
    );
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

  static MaterialTapTargetSize parseMaterialTapTargetSize(String value) {
    switch (value) {
      case "padded":
        return MaterialTapTargetSize.padded;
      case "shrinkWrap":
        return MaterialTapTargetSize.shrinkWrap;
      default:
        return MaterialTapTargetSize.padded;
    }
  }
}
