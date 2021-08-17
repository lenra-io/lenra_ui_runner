import 'package:flutter/material.dart';
import 'package:components/page/simple_page.dart';
import 'package:components/register_page/register_form.dart';
import 'package:navigation/lenra_navigator.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      backInkText: "Revenir à la page de connexion",
      backInkAction: () {
        Navigator.pushNamed(context, LenraNavigator.LOGIN_ROUTE);
      },
      title: "Créez votre compte utilisateur",
      child: RegisterForm(),
    );
  }
}
