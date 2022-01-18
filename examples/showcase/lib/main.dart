
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:showcase/left_menu.dart';
import 'package:showcase/lenra_page.dart';
import 'package:showcase/pages/lenra_menu_page.dart';
import 'package:showcase/ui_builder.dart';

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
  var currentPage = LeftMenu.lenraMenuPage;

  LenraPage getPage() {
    switch (currentPage) {
      case LeftMenu.lenraMenuPage:
        return LenraMenuPage();
      // case LeftMenu.radioExample:
      //   return RadioExample();
      // case LeftMenu.lenraCheckboxPage:
      //   return LenraCheckboxPage();
      // case LeftMenu.lenraTogglePage:
      //   return LenraTogglePage();
      // case LeftMenu.lenraStatusStickerPage:
      //   return LenraStatusStickerPage();
      // case LeftMenu.lenraButtonPage:
      //   return LenraButtonPage();
      // case LeftMenu.lenraFlexPage:
      //   return LenraFlexPage();
      // case LeftMenu.lenraContainerPage:
      //   return LenraContainerPage();
      // case LeftMenu.lenraTextFieldPage:
      //   return LenraTextFieldPage();
      // case LeftMenu.lenraTextPage:
      //   return LenraTextPage();
      // case LeftMenu.lenraDropdownButtonPage:
      //   return LenraDropdownButtonPage();
      // case LeftMenu.lenraFlexiblePage:
      //   return LenraFlexiblePage();
      // case LeftMenu.lenraWrapPage:
      //   return LenraWrapPage();
      // case LeftMenu.lenraStackPage:
      //   return LenraStackPage();
      // case LeftMenu.lenraSliderPage:
      //   return LenraSliderPage();
      // case LeftMenu.lenraOverlayEntryPage:
      //   return LenraOverlayEntryPage();
      // case LeftMenu.lenraIconPage:
      //   return LenraIconPage();
    }
    return LenraMenuPage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WidgetModel>(create: (_) => WidgetModel()),
        Provider<UiBuilderModel>(create: (_) => UiBuilderModel(context, getPage().getUi(getPage().getData(OnPressedEvent(code: "InitData"))), getPage().getData))
      ],
      child: NotificationListener<Event>(
        onNotification: (Event event) => context.read<UiBuilderModel>().handleNotifications(context, event),
        child: LenraTheme(
          themeData: LenraThemeData(),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: Scaffold(
              appBar: AppBar(),
              drawer: Drawer(
                child: LeftMenu(
                  currentMenu: currentPage,
                  onMenuTapped: (newMenu) {
                    setState(() {
                      currentPage = newMenu;
                    });
                  },
                ),
              ),
              body: LenraWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
