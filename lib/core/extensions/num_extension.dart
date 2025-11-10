import 'package:flutter/material.dart';

extension NumExtension on num {
  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get microseconds => Duration(microseconds: toInt());

  Duration get hours => Duration(hours: toInt());

  Radius get radius => Radius.circular(toDouble());

  String formatedTime() {
    int hour = toInt() ~/ 3600;
    int min = ((this - hour * 3600)) ~/ 60;
    int sec = toInt() - (hour * 3600) - (min * 60);

    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    if (hour > 0) {
      return "$hour:$minute:$second";
    }
    return "$minute:$second";
  }
}

extension IntExtension on int {
  String formatedLocale() {
    if (this == 1) {
      return "vi";
    }
    if (this == 2) {
      return "en";
    }

    return "en";
  }

  String formatTime() {
    int minutes = this ~/ 60;
    int secs = this % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }
}

extension NumNullableExtension on num? {
  bool toBool() => this == 1;
  BorderRadius get radiusAll =>
      BorderRadius.all(Radius.circular((this ?? 0).toDouble()));
}
