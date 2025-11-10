import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_loading_widget.dart';
import 'loading_dialog.dart';

class CustomLoading {
  factory CustomLoading() => _instance;
  static final CustomLoading _instance = CustomLoading._internal();
  static CustomLoading get instance => _instance;

  CustomLoading._internal() {
    indicatorWidget = const LoadingWidget();
  }

  Widget? _w;
  Widget? get w => _w;

  Widget? indicatorWidget;

  OverlayEntry? overlayEntry;

  static BuildContext? dismissContext;

  static Future<void> show({BuildContext? context}) async {
    dismissContext = context;
    return instance._show();
  }

  static Future<void> showSuccess({Widget? widget}) async {
    return instance._show(widget: widget ?? Container());
  }

  static Future<void> showDialogSharing(BuildContext context, {Widget? widget}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> dismiss({BuildContext? context}) async {
    if(dismissContext == context && context != null || dismissContext == null) {
      return instance._dismiss();
    }
  }

  Future<void> _dismiss() async {
    dismissContext = null;
    _w = null;
    overlayEntry?.markNeedsBuild();
  }

  Future<void> _show({Widget? widget}) async {
    _w = Container(
        color: Colors.black.withOpacity(0.45),
        alignment: Alignment.center,
        child: widget ?? indicatorWidget);
    overlayEntry?.markNeedsBuild();
  }

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, CustomLoadingWidget(child: child));
      } else {
        return CustomLoadingWidget(child: child);
      }
    };
  }
}
