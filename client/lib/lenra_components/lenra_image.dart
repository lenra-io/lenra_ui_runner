import 'package:flutter/material.dart';
import 'package:config/config.dart';
import 'package:models/auth_model.dart';
import 'package:models/user_application_model.dart';
import 'package:provider/provider.dart';

class LenraImage extends StatelessWidget {
  final String? path;

  LenraImage({
    this.path,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModel>();
    String? appName = context.read<UserApplicationModel>().currentApp;

    return Image.network(
      "${Config.instance.httpEndpoint}/api/apps/$appName/resources/${this.path}?token=${authModel.accessToken}",
    );
  }
}
