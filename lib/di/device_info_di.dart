import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:device_info_plus/device_info_plus.dart';


class DeviceInfoDi {
  DeviceInfoDi._();

  static Future<void> init(GetIt injector) async {
    if (Platform.isAndroid) {
      injector.registerSingletonAsync<AndroidDeviceInfo>(
          () async => await DeviceInfoPlugin().androidInfo);
    }

  }
}
