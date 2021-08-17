import 'package:api/response_models/api_response.dart';

enum UserRole { unverified_user, user, dev, admin }

class User extends ApiResponse {
  int id;
  String email;
  String? firstName;
  String? lastName;
  UserRole role;

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        email = json["email"],
        firstName = json["first_name"],
        lastName = json["last_name"],
        role = UserRole.values.firstWhere((a) => a.toString() == "UserRole.${json['role']}");
}
