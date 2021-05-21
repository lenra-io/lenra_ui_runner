import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/redux/actions/refresh_token_action.dart';
import 'package:fr_lenra_client/redux/store.dart';

class AuthorizedGuard extends PageGuard {
  final List<UserRole> roles;

  AuthorizedGuard({@required Widget child, this.roles = UserRole.values}) : super(child: child);

  @override
  bool isAuthorized() {
    AuthResponse authResponse = LenraStore.getStore().state.authState.authResponse;
    return authResponse != null &&
        authResponse.accessToken != null &&
        authResponse.user != null &&
        (this.roles.contains(authResponse.user.role));
  }

  @override
  void ifUnauthorized() {
    LenraStore.dispatch(RefreshTokenAction(null));
  }
}
