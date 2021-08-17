import 'package:flutter/material.dart';
import 'package:api/response_models/api_errors.dart';
import 'package:components/error_list.dart';
import 'package:components/loading_button.dart';
import 'package:models/auth_model.dart';
import 'package:utils/form_validators.dart';
import 'package:provider/provider.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String oldPassword = "";
  String newPassword = "";
  String newPasswordConfirmation = "";

  bool _passwordVisible = true;
  bool _passwordVisibleConfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isChangingPassword = context.select<AuthModel, bool>((m) => m.changePasswordStatus.isFetching());
    ApiErrors? changePasswordErrors = context.select<AuthModel, ApiErrors?>((m) => m.changePasswordStatus.errors);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Entrez votre mot de passe',
              labelText: 'Mot de passe :',
            ),
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                this.oldPassword = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Entrez votre nouveau mot de passe',
              labelText: 'Nouveau mot de passe :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            obscureText: _passwordVisible,
            onChanged: (String value) {
              setState(() {
                this.newPassword = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Confirmation du nouveau mot de passe',
              labelText: 'Nouveau mot de passe :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisibleConfirm ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisibleConfirm = !_passwordVisibleConfirm;
                  });
                },
              ),
            ),
            obscureText: _passwordVisibleConfirm,
            onChanged: (String value) {
              setState(() {
                this.newPasswordConfirmation = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LoadingButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  this.context.read<AuthModel>().changePassword(
                        this.oldPassword,
                        this.newPassword,
                        this.newPasswordConfirmation,
                      );
                }
              },
              text: 'Confirmer',
              loading: isChangingPassword,
            ),
          ),
          ErrorList(changePasswordErrors),
        ],
      ),
    );
  }
}
