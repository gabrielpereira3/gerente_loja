import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(this.icon, this.hint, this.obscure, {Key? key})
      : super(key: key);

  final IconData icon;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
      ),
      style: const  TextStyle(color: Colors.white),
      obscureText: obscure,
    );
  }
}
