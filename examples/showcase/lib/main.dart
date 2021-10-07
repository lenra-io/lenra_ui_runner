import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:showcase/left_menu.dart';
import 'package:showcase/pages/lenra_menu_page.dart';
import 'package:showcase/pages/lenra_radio_page.dart';
import 'package:showcase/pages/lenra_checkbox_page.dart';
import 'package:showcase/pages/lenra_text_page.dart';
import 'package:showcase/pages/lenra_toggle_page.dart';
import 'package:showcase/pages/lenra_status_sticker_page.dart';
import 'package:showcase/pages/lenra_button_page.dart';
import 'package:showcase/pages/lenra_flex_page.dart';
import 'package:showcase/pages/lenra_styled_container_page.dart';
import 'package:showcase/pages/lenra_textfield_page.dart';

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
      case LeftMenu.lenraStyledContainerPage:
        return LenraStyledContainerPage();
      case LeftMenu.lenraTextFieldPage:
        return LenraTextFieldPage();
      case LeftMenu.lenraTextPage:
        return LenraTextPage();
    }
    return Text("N/A");
  }

  @override
  Widget build(BuildContext context) {
    return LenraTheme(
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
    );
  }
}
