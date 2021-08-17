import 'package:flutter/material.dart';
import 'package:components/login_page/login_form.dart';
import 'package:components/page/simple_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: LoginForm(),
    );
  }
}
