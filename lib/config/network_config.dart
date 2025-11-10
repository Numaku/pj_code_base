import '../core/constant/app_constant.dart';
import 'env_config.dart';

class NetWorkConfig {
  String? baseFileUrl;
  String baseUrl = "";
  String? apiKey;
  String? version;
  int connectTimeout;
  int receiveTimeout;

  NetWorkConfig._internal({
    required this.version,
    this.connectTimeout = AppConstants.connectionTimeOut,
    this.receiveTimeout = AppConstants.connectionTimeOut
  }) {
    baseFileUrl = EnvConfig.getBaseFileUrl();
    baseUrl = EnvConfig.getBaseUrl();
  }

  static Future<NetWorkConfig> create() async {
    // final version = await AppUtils.getAppVersionName();
    //TODO fixme get app version
    const version = "1.0.0"; // Placeholder for version
    return NetWorkConfig._internal(
      version: version,
    );
  }
}
