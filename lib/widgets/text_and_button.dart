import 'package:flutter/material.dart';

class TextAndButton extends StatelessWidget {
  final String text;
  final String btnText;
  final VoidCallback callback;
  const TextAndButton({
    super.key,
    required this.text,
    required this.btnText,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          TextButton(
            onPressed: callback,
            child: Text(btnText),
          )
        ],
      ),
    );
  }
}
