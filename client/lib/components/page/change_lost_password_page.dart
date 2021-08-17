import 'package:flutter/material.dart';
import 'package:components/login_page/change_lost_password_form.dart';
import 'package:components/page/simple_page.dart';

class ChangeLostPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    return SimplePage(
      title: "Re-définissez un mot de passe pour votre compte Lenra",
      child: ChangeLostPasswordForm(email: email),
    );
  }
}
