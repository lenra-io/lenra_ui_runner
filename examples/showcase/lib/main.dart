import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:showcase/left_menu.dart';
import 'package:showcase/my_app.dart';
import 'package:showcase/pages/lenra_status_sticker_page.dart';
import 'package:showcase/pages/lenra_button_page.dart';
import 'package:showcase/pages/lenra_flex_page.dart';

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
  var currentMenu = LeftMenu.myTestApp;

  Widget buildBody() {
    switch (currentMenu) {
      case LeftMenu.myTestApp:
        return MyTestApp();
      case LeftMenu.lenraStatusStickerPage:
        return LenraStatusStickerPage();
      case LeftMenu.lenraButtonPage:
        return LenraButtonPage();
      case LeftMenu.lenraFlexPage:
        return LenraFlexPage();
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
                  this.currentMenu = newMenu;
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
