import 'package:flutter/material.dart';

class NonOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
