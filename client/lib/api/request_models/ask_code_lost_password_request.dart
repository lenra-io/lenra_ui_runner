import 'package:api/request_models/api_request.dart';

class AskCodeLostPasswordRequest extends ApiRequest {
  final String email;

  AskCodeLostPasswordRequest(this.email);

  Map<String, String> toJson() => {
        'email': email,
      };
}
