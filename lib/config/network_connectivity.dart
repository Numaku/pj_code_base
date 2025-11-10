import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  static Future<bool> get status async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }
}
