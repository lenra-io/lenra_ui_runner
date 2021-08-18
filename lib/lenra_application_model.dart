import 'package:flutter/foundation.dart';

class LenraApplicationModel extends ChangeNotifier {
  final String httpEndpoint;
  final String applicationName;
  final String accessToken;

  LenraApplicationModel(this.httpEndpoint, this.applicationName, this.accessToken);
}