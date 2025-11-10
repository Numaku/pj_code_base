import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../feature/widget/common/avoid_double_click_widget.dart';
import '../../util/app_utils.dart';

extension WidgetExtension on Widget {
  static bool _clicked = false;
  static bool get clicked => _clicked;
  static set clicked(bool value) => _clicked = value;

  Widget buildListViewInScrollView({bool isInScrollView = false}){
    if(isInScrollView) {
      return this;
    }else{
      return expanded();
    }
  }

  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Align align(
          {AlignmentGeometry alignment = Alignment.center,
          double? widthFactor,
          double? heightFactor}) =>
      Align(
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );

  CupertinoButton onCupertinoClick(VoidCallback onClick,
      {bool hideKeyboard = true}) {
    return CupertinoButton(
      onPressed: () {
        if (hideKeyboard) {
          AppUtils.hideKeyboard();
        }
        onClick();
      },
      padding: EdgeInsets.zero,
      minSize: 0,
      child: this,
    );
  }

  Container marginOnly(
          {double top = 0,
          double left = 0,
          double right = 0,
          double bottom = 0}) =>
      Container(
        margin:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Container margin(double value) => Container(
        margin: EdgeInsets.all(value),
        child: this,
      );

  Padding paddingOnly(
          {double top = 0,
          double left = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
        padding:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Padding paddingSymetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this,
      );

  Widget onClick(Function() onClickListener,
          {HitTestBehavior hitTestBehavior = HitTestBehavior.opaque,
          bool isUnfocusTextField = true}) =>
      onGestureClick(
        onClickListener,
        isUnfocusTextField: isUnfocusTextField,
        hitTestBehavior: hitTestBehavior,
      );

  Widget onGestureClick(
    VoidCallback onClick, {
    bool hideKeyboard = true,
    HitTestBehavior hitTestBehavior = HitTestBehavior.opaque,
    bool isUnfocusTextField = true,
    Duration delay = const Duration(milliseconds: 800),
    VoidCallback? onLongClick
  }) {
    return AvoidDoubleClickWidget(
      behavior: hitTestBehavior,
      onClick: onClick,
      delay: delay,
      isUnfocusTextField: isUnfocusTextField,
      onLongClick: onLongClick,
      child: this,
    );
  }

  Widget onInkWellClick(VoidCallback onTap, {bool hideKeyboard = true}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        onTap: () {
          if (hideKeyboard) {
            AppUtils.hideKeyboard();
          }
          onTap();
        },
        child: this,
      ),
    );
  }

  Padding paddingAll(double value, {Key? key}) => Padding(
        key: key,
        padding: EdgeInsets.all(value),
        child: this,
      );

  Padding paddingLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Padding paddingFromViewPadding(
    ViewPadding padding,
    double devicePixelRatio, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromViewPadding(padding, devicePixelRatio),
        child: this,
      );

  Padding paddingSymmetric(
          {double vertical = 0.0, double horizontal = 0.0, Key? key}) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );

  SizedBox square(double size) =>
      SizedBox(height: size, width: size, child: this);
}
