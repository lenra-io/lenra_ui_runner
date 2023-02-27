import 'package:flutter/foundation.dart';

class LenraApplicationModel extends ChangeNotifier {
  final String httpEndpoint;
  final String applicationName;
  final String accessToken;

  LenraApplicationModel({
    required this.httpEndpoint,
    required this.applicationName,
    required this.accessToken,
  });
}
