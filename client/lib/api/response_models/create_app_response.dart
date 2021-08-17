import 'package:api/response_models/api_response.dart';
import 'package:api/response_models/app_response.dart';

class CreateAppResponse extends ApiResponse {
  AppResponse app;

  CreateAppResponse.fromJson(Map<String, dynamic> json) : app = AppResponse.fromJson(json["app"]);
}
