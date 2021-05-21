import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/redux/models/change_lost_password_model.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

class ChangeLostPasswordForm extends StatefulWidget {
  final ChangeLostPasswordModel changeLostPasswordModel;
  final String email;

  ChangeLostPasswordForm({this.changeLostPasswordModel, this.email});

  @override
  _ChangeLostPasswordState createState() {
    return _ChangeLostPasswordState();
  }
}

class _ChangeLostPasswordState extends State<ChangeLostPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String newPassword;
  String newPasswordConfirmation;

  String code;
  bool _passwordVisible;
  bool _passwordVisibleConfirm;

  @override
  void initState() {
    _passwordVisible = true;
    _passwordVisibleConfirm = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    return Form(
      key: _formKey,
      child: LenraColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        separationFactor: 3,
        children: <Widget>[
          LenraTextFormField(
            label: "Entrez le code reçu",
            description:
                "Si vous n’avez pas reçu le code, l’email était probablement mauvais. Si vous êtes absolument certain de votre email, veuillez nous contacter.",
            onChanged: (String value) {
              this.code = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 8),
            ]),
          ),
          Text(
            "Nouveau mot de passe",
            textAlign: TextAlign.left,
            style: finalLenraTextThemeData.headline3,
          ),
          LenraTextFormField(
            label: "Définissez un mot de passe",
            description: "8 caractères, 1 majuscule, 1 minuscule et 1 caractère spécial.",
            obscure: _passwordVisible,
            onChanged: (String value) {
              this.newPassword = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
              checkPassword(),
            ]),
          ),
          LenraTextFormField(
            label: "Confirmez le mot de passe",
            obscure: _passwordVisibleConfirm,
            onChanged: (String value) {
              this.newPasswordConfirmation = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
              checkPassword(),
            ]),
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              text: "Modifier mon mot de passe",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  widget.changeLostPasswordModel.fetchData(
                      body: ChangeLostPasswordRequest(code, widget.email, newPassword, newPasswordConfirmation));
                }
              },
            ),
          ),
          ErrorList(this.widget.changeLostPasswordModel.errors),
        ],
      ),
    );
  }
}