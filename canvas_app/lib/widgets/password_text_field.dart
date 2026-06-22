import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Passwort',
        fillColor: Colors.grey,
        filled: true,
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglePasswordVisibility();
          },
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
