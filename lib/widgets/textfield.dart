import 'package:flutter/material.dart';
import 'package:todo_supabase/utils/colors.dart';

class TodoTextField extends StatelessWidget {
  final bool obscureText;
  final TextInputType inputType;
  final IconData icon;
  final String label;
  final TextEditingController controller;

  const TodoTextField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.inputType,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      obscureText: obscureText,
      textInputAction: TextInputAction.none,
      autofocus: false,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: textfieldFillColor,
        filled: true,
        border: InputBorder.none,
        prefixIcon: Icon(icon),
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? seedColor
                : inactiveColor),
      ),
    );
  }
}
