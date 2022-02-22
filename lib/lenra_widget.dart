import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:lenra_ui_runner/components/lenra_button.dart';
import 'package:lenra_ui_runner/components/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/components/lenra_overlay_entry.dart';
import 'package:lenra_ui_runner/components/lenra_radio.dart';
import 'package:lenra_ui_runner/components/lenra_text.dart';
import 'package:lenra_ui_runner/components/lenra_textfield.dart';
import 'package:lenra_ui_runner/props_parser.dart';
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

class LenraWidget extends StatelessWidget {
  static late Function appErrorUI;
  static late Function appErrorCallback;
  static List<Widget> _errors = [];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ui = context.select<WidgetModel, Map<String, dynamic>>((model) => model.ui);

    bool error = context.select<WidgetModel, bool>((model) => model.error);

    if (error) {
      List<Widget> error = context.select<WidgetModel, List<Widget>>((model) => model.errors);
      LenraWidget._errors = error;
      appErrorCallback(context, error);
    }

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return LenraWidget.parseJson(ui["root"]);
    }

    return LenraWidget.parseJson(ui);
  }

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
  };

  static Widget parseJson(Map<String, dynamic> json) {
    if (json.isEmpty) return appErrorUI(_errors);

    String? type = getType(json);
    if (type == null) {
      throw "No type in component. It should never happen";
    }
    LenraComponentBuilder? builder = getComponentBuilder(type);
    if (builder == null) throw "Componnent mapping does not handle type $type";
    Map<Symbol, dynamic> parsedProps = parseProps(json, builder.propsTypes);
    return builder.build(parsedProps);
  }

  static String? getType(Map<String, dynamic> json) {
    return json['type'] as String?;
  }

  static LenraComponentBuilder? getComponentBuilder(String type) {
    if (componentsMapping.containsKey(type)) {
      return componentsMapping[type];
    }

    return null;
  }

  static Map<Symbol, dynamic> parseProps(Map<String, dynamic> json, Map<String, Type> propsTypes) {
    Map<Symbol, dynamic> transformedProps = {};

    json.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        Function? parser = getParser(propsTypes[key]!);
        if (parser != null) {
          transformedProps[Symbol(key)] = parser(value);
        }
      }
    });

    return transformedProps;
  }

  static Function? getParser(Type t) {
    return ParserExt.typeParsers[t];
  }
}
