import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(this.icon, this.hint, this.obscure, this.stream, this.onChanged, {Key? key})
      : super(key: key);

  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
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
            contentPadding: const EdgeInsets.only(left: 5, right: 20, top: 20, bottom: 20),
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: obscure,
        );
      }
    );
  }
}
