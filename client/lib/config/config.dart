import 'package:utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:utils/connexion_utils_web.dart';

enum Application { app, dev }

class Config {
  static final _instance = Config._();
  static Config get instance => _instance;

  final Application application;
  final String httpEndpoint;
  final String wsEndpoint;
  final String basicAuth;
  final String appBaseUrl;

  Config({
    required this.application,
    required this.httpEndpoint,
    required this.wsEndpoint,
    required this.basicAuth,
    required this.appBaseUrl,
  });

  static _() {
    String basicAuth = _computeBasicAuth();
    String httpEndpoint = _computeHttpEndpoint();
    String wsEndpoint = _computeWsEndpoint(httpEndpoint);
    Application application = _computeApplication(httpEndpoint);
    String appBaseUrl = _computeAppBaseUrl(application);

    return Config(
        application: application,
        httpEndpoint: httpEndpoint,
        wsEndpoint: wsEndpoint,
        basicAuth: basicAuth,
        appBaseUrl: appBaseUrl);
  }

  static String _computeHttpEndpoint() {
    String httpEndpoint = const String.fromEnvironment("LENRA_SERVER_URL");
    if (httpEndpoint.isEmpty) {
      httpEndpoint = getServerUrl();
    }
    return httpEndpoint;
  }

  static String _computeAppBaseUrl(Application app) {
    String appBaseUrl = getServerUrl();
    if (app == Application.dev) {
      appBaseUrl = appBaseUrl.replaceFirst("dev", "app");
    }

    appBaseUrl += "/#/app/";
    return appBaseUrl;
  }

  static String _computeBasicAuth() {
    return const String.fromEnvironment("LENRA_BASIC_AUTH");
  }

  static String _computeWsEndpoint(String httpEndpoint) {
    String wsEndpoint = httpEndpoint.replaceFirst(RegExp("^http"), "ws");
    wsEndpoint += "/socket/websocket";
    return wsEndpoint;
  }

  static Application _computeApplication(String httpEndpoint) {
    String appName = const String.fromEnvironment("LENRA_APPLICATION");
    if (appName.isEmpty) {
      appName = httpEndpoint.replaceAllMapped(RegExp("^https?://([^/.]+)([/.].*)?\$"), (match) {
        return match.group(1)!;
      });
    }
    return Application.values.firstWhere((a) => a.toString() == "Application.$appName", orElse: () => Application.app);
  }
}
