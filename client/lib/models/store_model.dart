import 'package:flutter/cupertino.dart';
import 'package:api/application_api.dart';
import 'package:api/response_models/app_response.dart';
import 'package:api/response_models/apps_response.dart';
import 'package:models/status.dart';

class StoreModel extends ChangeNotifier {
  Status<AppsResponse> fetchApplicationsStatus = Status();
  List<AppResponse> applications = [];

  Future<List<AppResponse>> fetchApplications() async {
    var res = await fetchApplicationsStatus.handle(ApplicationApi.getApps, notifyListeners);
    this.applications = res.apps;
    notifyListeners();
    return res.apps;
  }
}
