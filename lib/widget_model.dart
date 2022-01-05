import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:lenra_ui_runner/components/lenra_button.dart';
import 'package:lenra_ui_runner/components/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/components/lenra_overlay_entry.dart';
import 'package:lenra_ui_runner/components/lenra_radio.dart';
import 'package:lenra_ui_runner/components/lenra_text.dart';
import 'package:lenra_ui_runner/components/lenra_textfield.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
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

class WidgetModel extends ChangeNotifier {
  Map<String, dynamic> _ui = {};

  Map<String, dynamic> get ui => _ui;

  void replaceUi(Map<String, dynamic> ui) {
    _ui = ui;
    notifyListeners();
  }

  void patchUi(Iterable<dynamic> patches) {
    replaceUi(JsonPatch.apply(_ui, patches as Iterable<Map<String, dynamic>>, strict: false));
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
    if (json.isEmpty) return Text("No Components.");

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
