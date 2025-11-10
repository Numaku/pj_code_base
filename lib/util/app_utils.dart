import 'dart:convert';
import 'dart:io';
import 'package:dental_clinic_app/core/extensions/context_extension.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, MethodChannel, PlatformException, SystemChannels, rootBundle;
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);
}

class Triple<F, S, T> {
  final F first;
  final S second;

  final T third;

  Triple(this.first, this.second, this.third);
}

class AppUtils {
  static double getHeightToolBarInChatScreen(BuildContext context){
    return 70 + context.statusBarHeight;
  }
  static void showToast(String? msg) {
    if (msg != null) {
      //todo show toast
    }
  }

  static void copy(String? content) async {
    await Clipboard.setData(ClipboardData(text: content ?? ""));
  }

  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static Future<void> requestPermission(
      {required Permission permission, required BuildContext context}) async {
    await permission.request().then((status) {
      if (status.isDenied || status.isPermanentlyDenied) {
        throw context.showAlertDialog(
          onPressed: openAppSettings,
          content: "request Permission",
        );
      } else {
        return;
      }
    });
  }

  static Permission galleryPermission({bool isCheckPhotoIOS = true}) {
    late Permission permission;
    if (Platform.isAndroid) {
      final androidSdkVersion = GetIt.I.get<AndroidDeviceInfo>().version.sdkInt;
      permission = androidSdkVersion >= 33
          ? Permission.photos
          : Permission.storage;
    } else {
      if (isCheckPhotoIOS) {
        permission = Permission.photos;
      } else {
        permission = Permission.storage;
      }
    }
    return permission;
  }


  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static String replyFormatMessage(
          {int? messageId, String? name, int? userId}) =>
      "[rp aid=$userId to=$messageId] $name\n";



  String getFileExtension(String filePath) {
    List<String> pathSegments = filePath.split('/');
    String fileName = pathSegments.last;
    List<String> fileNameSegments = fileName.split('.');
    if (fileNameSegments.length > 1) {
      return fileNameSegments.last;
    } else {
      return '';
    }
  }


  static VoidCallback avoidDoubleTab(VoidCallback action, [int delayMs = 800]) {
    bool canTap = true;
    return () {
      if (!canTap) return;
      canTap = false;
      action();
      Future.delayed(Duration(milliseconds: delayMs), () => canTap = true);
    };
  }
}
