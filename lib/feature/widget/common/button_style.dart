import 'package:flutter/material.dart';
import 'easy_color.dart';

class ButtonStyleWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;

  const ButtonStyleWidget({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // đảm bảo xanh lá
            foregroundColor: Colors.white,
            overlayColor: Colors.black,// màu chữ
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}