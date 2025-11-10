import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/constant/argument_key.dart';

class AppRoutes {
  static PageRoute getRoute(RouteSettings settings,
      {Map<String, dynamic>? arguments}) {
    late final Widget widget;
    TransitionType? transitionType;

    if (settings.arguments != null) {
      transitionType = (settings.arguments
          as Map<String, dynamic>)[ArgumentKey.transitionType];
    }
    try {
      widget =
          GetIt.I.get<Widget>(instanceName: settings.name, param1: arguments);
    } catch (e) {
      widget = Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Page not found'),
        ),
        body: const Center(child: Text('Page not found')),
      );
    }
    if (transitionType != TransitionType.platform && transitionType != null) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case TransitionType.slideUp:
                {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                }

              default:
                return child;
            }
          });
    } else {
      return Platform.isAndroid
          ? MaterialPageRoute(builder: (context) => widget, settings: settings)
          : CupertinoPageRoute(
          builder: (context) => widget, settings: settings);
    }
  }
}

enum TransitionType { platform, slideUp, fade }
