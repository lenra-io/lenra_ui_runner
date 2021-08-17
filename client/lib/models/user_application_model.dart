import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api/application_api.dart';
import 'package:api/request_models/create_app_request.dart';
import 'package:api/response_models/app_response.dart';
import 'package:api/response_models/apps_response.dart';
import 'package:api/response_models/create_app_response.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:models/status.dart';

class UserApplicationModel extends ChangeNotifier {
  Status<AppsResponse> fetchApplicationsStatus = Status();
  Status<CreateAppResponse> createApplicationStatus = Status();

  List<AppResponse> userApps = [];
  String? currentApp;

  Future<List<AppResponse>> fetchUserApplications() async {
    var res = await fetchApplicationsStatus.handle(ApplicationApi.getUserApps, notifyListeners);
    this.userApps = res.apps;
    notifyListeners();
    return res.apps;
  }

  Future<AppResponse> createApp(String appName, String gitRepository) async {
    var res = await createApplicationStatus.handle(
        () => ApplicationApi.createApp(
              CreateAppRequest(
                color: LenraColorThemeData.LENRA_FUN_GREEN_BASE,
                icon: Icons.apps,
                name: appName,
                repository: gitRepository,
              ),
            ),
        notifyListeners);
    this.userApps.add(res.app);
    notifyListeners();
    return res.app;
  }

  AppResponse? get selectedApp {
    if (userApps.isEmpty) return null;
    return userApps.last;
  }
}
