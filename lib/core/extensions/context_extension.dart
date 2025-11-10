import 'package:flutter/material.dart';
import '../../config/app_routes.dart';
import '../constant/argument_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(result);
  }

  void popUntilFirst({bool rootNavigator = true}) {
    Navigator.of(this, rootNavigator: rootNavigator).popUntil((route) => route.isFirst);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    TransitionType transitionType = TransitionType.platform,
    Map<String, dynamic>? arguments,
  }) {
    final pushArguments = <String, dynamic>{
      ArgumentKey.transitionType: transitionType,
    };
    if (arguments != null) {
      pushArguments.addAll(arguments);
    }
    return Navigator.of(this, rootNavigator: rootNavigator).pushNamed<T>(
      routeName,
      arguments: pushArguments,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Map<String, dynamic>? arguments,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    bool rootNavigator = false,
    Map<String, dynamic>? arguments,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushNamedAndRemoveUntil(
        routeName,
        predicate,
        arguments: arguments,
      );

  Future<void> showAlertDialog(
      {required String content, VoidCallback? onPressed, String title = ""}) {
    return showDialog<void>(
      context: this,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop();
                onPressed?.call();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> showBottomSheet(Widget child, {ShapeBorder? shape}) {
    return showModalBottomSheet(
      context: this,
      useRootNavigator: true,
      shape: shape,
      builder: (context) => child,
      clipBehavior: Clip.hardEdge,
    );
  }

  Future<T?> showAppDialog<T>(Widget child) {
    return showDialog(
      context: this,
      builder: (context) => child,
    );
  }

  void showContextMenu(List<String> choices,
      {GlobalKey? key, required Function(int) onClickListener}) async {
    final RenderObject? overlay = Overlay.of(this).context.findRenderObject();

    final tapPosition = (key?.currentContext?.findRenderObject() as RenderBox)
        .globalToLocal(Offset.zero);

    final result = await showMenu(
        context: this,
        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(tapPosition.dx.abs(), tapPosition.dy.abs(), 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList());
    if (result != null) {
      onClickListener(choices.indexOf(result));
    }
  }


  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get statusBarHeight => MediaQuery.viewPaddingOf(this).top;

  double get safeAreaBottomHeight => MediaQuery.viewPaddingOf(this).bottom;

  double get bottomBarHeight =>
      kBottomNavigationBarHeight + safeAreaBottomHeight;

  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;


  void hideKeyBoard() {
    FocusScope.of(this).unfocus();
  }


}
