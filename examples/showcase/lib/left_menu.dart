import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key, required this.onMenuTapped, required this.currentMenu})
      : super(key: key);

  final Function(String) onMenuTapped;
  final String currentMenu;

  static const myTestApp = "myTestApp";
  static const lenraButtonPage = "lenraButtonPage";
  static const lenraFlexPage = "lenraFlexPage";

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
        createMenu(context, 'MyTestApp', myTestApp),
        createMenu(context, 'LenraButtonPage', lenraButtonPage),
        createMenu(context, 'Lenra Flex', lenraFlexPage),
      ],
    );
  }

  Widget createMenu(BuildContext context, String title, String id) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: id == this.currentMenu ? Colors.grey : Colors.blue)),
      onTap: () {
        onMenuTapped(id);
        Navigator.of(context).pop();
      },
    );
  }
}
