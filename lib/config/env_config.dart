
import '../core/constant/app_constant.dart';

class EnvConfig {
  // static const baseUrl = String.fromEnvironment("BASE_URL");
  static const baseUrl = "";
  static const baseStgUrl = "";
  static const baseProdUrl = "";
  static const baseFileUrl = "";
  static const baseStgFileUrl = "";
  static const baseProdFileUrl = "";
  static const baseSocketUrl = "";
  static const baseStgSocketUrl = "";
  static const baseProdSocketUrl = "";

  static bool isDevelopment() => flavor == EnvConstants.developmentEnv;
  static bool isStaging() => flavor == EnvConstants.stagingEnv;
  static bool isProduction() => flavor == EnvConstants.productionEnv;

  static String _apiBaseUrl = "";
  static String _fileBaseUrl = "";
  static String _socketBaseUrl = "";
  static String flavor = const String.fromEnvironment("FLUTTER_APP_FLAVOR");


  EnvConfig.dev(){
    _apiBaseUrl = baseUrl;
    _fileBaseUrl = baseFileUrl;
    _socketBaseUrl = baseSocketUrl;
    flavor = EnvConstants.developmentEnv;
  }

  EnvConfig.staging(){
    _apiBaseUrl = baseStgUrl;
    _fileBaseUrl = baseStgFileUrl;
    _socketBaseUrl = baseStgSocketUrl;
    flavor = EnvConstants.stagingEnv;
  }

  EnvConfig.production(){
    _apiBaseUrl = baseProdUrl;
    _fileBaseUrl = baseProdFileUrl;
    _socketBaseUrl = baseProdSocketUrl;
    flavor = EnvConstants.productionEnv;
  }


  static String getBaseUrl(){
    return _apiBaseUrl;
  }

  static String getBaseFileUrl(){
    return _fileBaseUrl;
  }
  static String getSocketUrl(){
    return _socketBaseUrl;
  }

}
