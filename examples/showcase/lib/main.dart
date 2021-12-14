import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:showcase/left_menu.dart';
import 'package:showcase/pages/lenra_dropdown_button.dart';
import 'package:showcase/pages/lenra_flexible_page.dart';
import 'package:showcase/pages/lenra_menu_page.dart';
import 'package:showcase/pages/lenra_radio_page.dart';
import 'package:showcase/pages/lenra_checkbox_page.dart';
import 'package:showcase/pages/lenra_stack_page.dart';
import 'package:showcase/pages/lenra_slider_page.dart';
import 'package:showcase/pages/lenra_text_page.dart';
import 'package:showcase/pages/lenra_toggle_page.dart';
import 'package:showcase/pages/lenra_status_sticker_page.dart';
import 'package:showcase/pages/lenra_button_page.dart';
import 'package:showcase/pages/lenra_flex_page.dart';
import 'package:showcase/pages/lenra_container_page.dart';
import 'package:showcase/pages/lenra_textfield_page.dart';
import 'package:showcase/pages/lenra_wrap_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var currentMenu = LeftMenu.lenraMenuPage;

  Widget buildBody() {
    switch (currentMenu) {
      case LeftMenu.lenraMenuPage:
        return LenraMenuPage();
      case LeftMenu.radioExample:
        return RadioExample();
      case LeftMenu.lenraCheckboxPage:
        return LenraCheckboxPage();
      case LeftMenu.lenraTogglePage:
        return LenraTogglePage();
      case LeftMenu.lenraStatusStickerPage:
        return LenraStatusStickerPage();
      case LeftMenu.lenraButtonPage:
        return LenraButtonPage();
      case LeftMenu.lenraFlexPage:
        return LenraFlexPage();
      case LeftMenu.lenraContainerPage:
        return LenraContainerPage();
      case LeftMenu.lenraTextFieldPage:
        return LenraTextFieldPage();
      case LeftMenu.lenraTextPage:
        return LenraTextPage();
      case LeftMenu.lenraDropdownButtonPage:
        return LenraDropdownButtonPage();
      case LeftMenu.lenraFlexiblePage:
        return LenraFlexiblePage();
      case LeftMenu.lenraWrapPage:
        return LenraWrapPage();
      case LeftMenu.lenraStackPage:
        return LenraStackPage();
      case LeftMenu.lenraSliderPage:
        return LenraSliderPage();
    }
    return Text("N/A");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WidgetModel>(create: (_) => WidgetModel()),
      ],
      child: LenraTheme(
        themeData: LenraThemeData(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: Scaffold(
            appBar: AppBar(),
            drawer: Drawer(
              child: LeftMenu(
                currentMenu: currentMenu,
                onMenuTapped: (newMenu) {
                  setState(() {
                    currentMenu = newMenu;
                  });
                },
              ),
            ),
            body: buildBody(),
          ),
        ),
      ),
    );
  }
}
