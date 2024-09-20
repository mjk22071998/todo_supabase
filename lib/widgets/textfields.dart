import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool obscureText;
  final TextInputType inputType;
  final IconData icon;
  final String label;

  const MyTextField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.inputType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      obscureText: obscureText,
      textInputAction: TextInputAction.none,
      autofocus: false,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.blueGrey.shade100,
        filled: true,
        border: InputBorder.none,
        prefixIcon: Icon(icon),
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? Colors.blue
                : Colors.blueGrey.shade400),
      ),
    );
  }
}
