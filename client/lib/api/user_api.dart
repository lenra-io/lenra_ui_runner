import 'package:api/lenra_http_client.dart';
import 'package:api/request_models/ask_code_lost_password_request.dart';
import 'package:api/request_models/change_password_request.dart';
import 'package:api/request_models/loginRequest.dart';
import 'package:api/request_models/register_request.dart';
import 'package:api/request_models/send_code_lost_password_request.dart';
import 'package:api/request_models/validate_dev_request.dart';
import 'package:api/request_models/validate_user_request.dart';
import 'package:api/response_models/auth_response.dart';
import 'package:api/response_models/empty_response.dart';

class UserApi {
  static Future<AuthResponse> register(RegisterRequest body) => LenraAuth.instance.post(
        "/register",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );

  static Future<AuthResponse> login(LoginRequest body) => LenraAuth.instance.post(
        "/login",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );

  static Future<AuthResponse> validateUser(ValidateUserRequest body) => LenraAuth.instance.post(
        "/verify",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );

  static Future<AuthResponse> validateDev(ValidateDevRequest body) => LenraApi.instance.put(
        "/verify/dev",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );

  static Future<AuthResponse> refresh() => LenraAuth.instance.post(
        "/refresh",
        responseMapper: (json) => AuthResponse.fromJson(json),
      );

  static Future<EmptyResponse> logout() => LenraAuth.instance.post(
        "/logout",
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );
  static Future<EmptyResponse> changePassword(ChangePasswordRequest body) => LenraApi.instance.put(
        "/password",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> askCodeLostPassword(AskCodeLostPasswordRequest body) => LenraAuth.instance.put(
        "/password/lost",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> sendCodeLostPassword(SendCodeLostPasswordRequest body) => LenraAuth.instance.post(
        "/password/lost",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );
}
