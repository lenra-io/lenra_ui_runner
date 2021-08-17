import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:components/store_page/app_list.dart';
import 'package:components/store_page/logout_button.dart';

class StorePage extends StatefulWidget {
  StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.40,
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                alignment: Alignment.topRight,
                child: Wrap(direction: Axis.horizontal, alignment: WrapAlignment.spaceEvenly, children: [
                  LogoutButton(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Text('Profile'),
                  ),
                ])),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Container(
                  child: AppList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
