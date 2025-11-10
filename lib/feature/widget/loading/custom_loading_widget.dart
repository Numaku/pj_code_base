import 'package:flutter/material.dart';

import 'custom_loading.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({super.key, this.child});

  final Widget? child;

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) =>
          CustomLoading.instance.w ?? Container(),
    );
    CustomLoading.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: ((context) {
            return widget.child ?? Container();
          })),
          _overlayEntry
        ],
      ),
    );
  }
}
