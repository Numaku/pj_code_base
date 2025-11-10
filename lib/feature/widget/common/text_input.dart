import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextInput({
    super.key,
    required this.hintText,
    this.obsecureText = false,
    this.controller,
    this.validator,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF8C8C8C),
          ),
          filled: true,
          fillColor: const Color(0xFFF7F7F9),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.obsecureText
              ? IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
