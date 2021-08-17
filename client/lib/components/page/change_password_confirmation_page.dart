import 'package:flutter/material.dart';
import 'package:components/page/simple_page.dart';
import 'package:lenra_components/lenra_button.dart';
import 'package:navigation/lenra_navigator.dart';

class ChangePasswordConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Votre nouveau mot de passe a été correctement enregistré !",
      child: SizedBox(
        width: double.infinity,
        child: LenraButton(
          text: "Continuer sur  Lenra",
          onPressed: () {
            Navigator.pushNamed(context, LenraNavigator.HOME_ROUTE);
          },
        ),
      ),
    );
  }
}
