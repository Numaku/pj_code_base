import 'package:dental_clinic_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final String? url;
  final double size;
  final String? placeHolder;

  const AppCircleAvatar({
    super.key,
    this.url,
    this.size = 20,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: url?.loadImageUrl(isAvatar: true, placeHolder: placeHolder, ),
    );
  }
}
