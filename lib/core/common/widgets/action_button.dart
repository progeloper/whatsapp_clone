import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback callback;
  const ActionButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(50, 45),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
      onPressed: callback,
      child: Text(
        text,
        style: TextStyle(
          color: Palette.actionTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

  }
}
