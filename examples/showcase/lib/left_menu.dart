import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key, required this.onMenuTapped, required this.currentMenu}) : super(key: key);

  final Function(String) onMenuTapped;
  final String currentMenu;

  static const lenraMenuPage = "lenraMenuPage";
  static const radioExample = "radioExample";
  static const lenraCheckboxPage = "lenraCheckboxPage";
  static const lenraTogglePage = "lenraTogglePage";
  static const lenraStatusStickerPage = "lenraStatusStickerPage";
  static const lenraButtonPage = "lenraButtonPage";
  static const lenraFlexPage = "lenraFlexPage";
  static const lenraContainerPage = "lenraContainerPage";
  static const lenraTextFieldPage = "lenraTextFieldPage";
  static const lenraTextPage = "lenraTextPage";
  static const lenraDropdownButtonPage = "lenraDropdownButtonPage";
  static const lenraFlexiblePage = "lenraFlexiblePage";
  static const lenraWrapPage = "lenraWrapPage";
  static const lenraStackPage = "lenraStackPage";
  static const lenraSliderPage = "lenraSliderPage";
  static const lenraOverlayEntryPage = "lenraOverlayEntryPage";

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Examples'),
        ),
        createMenu(context, 'Lenra Menu and Menu Item Page', lenraMenuPage),
        createMenu(context, 'Radio Examples', radioExample),
        createMenu(context, 'Lenra Checkbox', lenraCheckboxPage),
        createMenu(context, 'Lenra Toggle', lenraTogglePage),
        createMenu(context, 'Lenra Status Sticker', lenraStatusStickerPage),
        createMenu(context, 'LenraButtonPage', lenraButtonPage),
        createMenu(context, 'Lenra Flex', lenraFlexPage),
        createMenu(context, 'Container', lenraContainerPage),
        createMenu(context, 'Lenra TextField', lenraTextFieldPage),
        createMenu(context, 'Lenra Text', lenraTextPage),
        createMenu(context, 'Dropdown Button', lenraDropdownButtonPage),
        createMenu(context, 'Lenra Flexible', lenraFlexiblePage),
        createMenu(context, 'Lenra Wrap', lenraWrapPage),
        createMenu(context, 'Lenra Stack', lenraStackPage),
        createMenu(context, 'Lenra Slider', lenraSliderPage),
        createMenu(context, 'OverlayEntry', lenraOverlayEntryPage),
      ],
    );
  }

  Widget createMenu(BuildContext context, String title, String id) {
    return ListTile(
      title: Text(title, style: TextStyle(color: id == currentMenu ? Colors.grey : Colors.blue)),
      onTap: () {
        onMenuTapped(id);
        Navigator.of(context).pop();
      },
    );
  }
}
