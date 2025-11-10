import 'package:flutter/material.dart';

import '../../../util/app_utils.dart';


class AvoidDoubleClickWidget extends StatefulWidget {
  const AvoidDoubleClickWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.delay = const Duration(milliseconds: 800),
    required this.isUnfocusTextField,
    required this.behavior,
    this.onLongClick
  });

  final Widget child;

  final VoidCallback onClick;

  final VoidCallback? onLongClick;

  final Duration delay;

  final bool isUnfocusTextField;

  final HitTestBehavior behavior;

  @override
  State<AvoidDoubleClickWidget> createState() => _AvoidDoubleClickWidgetState();
}

class _AvoidDoubleClickWidgetState extends State<AvoidDoubleClickWidget> {
  bool isDisableClick = false;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisableClick,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: _onClick,
        onLongPress: _onLongClick,
        child: widget.child,
      ),
    );
  }

  _onLongClick() {
    widget.onLongClick?.call();
  }

  _onClick() {
    widget.onClick();
    if (widget.isUnfocusTextField) {
      AppUtils.hideKeyboard();
    }
    setState(() {
      isDisableClick = true;
    });
    Future.delayed(widget.delay).then((value) => setState(() {
          isDisableClick = false;
        }));
  }
}
