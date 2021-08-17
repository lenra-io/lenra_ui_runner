import 'package:api/request_models/api_request.dart';

class ValidateUserRequest extends ApiRequest {
  final String code;

  ValidateUserRequest(this.code);

  dynamic toJson() => {
        "code": code,
      };
}
