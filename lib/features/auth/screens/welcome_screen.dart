import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Welcome to WhatsApp', style: TextStyle(
              color: Palette.textColor,
            ),),
          ],
        ),
      ),
    );
  }
}
