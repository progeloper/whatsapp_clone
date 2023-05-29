import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class InputTextField extends StatelessWidget {
  final Widget child;
  const InputTextField({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      constraints: const BoxConstraints(
        minWidth: double.maxFinite,
      ),
      decoration: BoxDecoration(
        color: Palette.backgroundColor,
        border: Border(
          bottom: BorderSide(color: Palette.tabColor, width: 1.5),
        )
      ),
      child: child,
    );
  }
}
