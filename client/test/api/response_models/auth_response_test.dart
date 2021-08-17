import 'package:flutter_test/flutter_test.dart';
import 'package:api/response_models/auth_response.dart';
import 'package:api/response_models/user.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "access_token": "myaccesstoken.truc.machin",
      "user": {
        "id": 1,
        "first_name": "John",
        "last_name": "Doe",
        "role": "user",
        "email": "john@doe.com",
      }
    };
    AuthResponse authResponse = AuthResponse.fromJson(json);
    expect(authResponse is AuthResponse, true);
    expect(authResponse.accessToken, "myaccesstoken.truc.machin");
    expect(authResponse.user is User, true);
    expect(authResponse.user.id, 1);
    expect(authResponse.user.email, "john@doe.com");
    expect(authResponse.user.firstName, "John");
    expect(authResponse.user.lastName, "Doe");
    expect(authResponse.user.role is UserRole, true);
    expect(authResponse.user.role, UserRole.user);
  });
}
