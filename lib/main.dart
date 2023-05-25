import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/screens/welcome_screen.dart';
import 'package:whatsapp_clone/theme/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Palette.backgroundColor,
      ),
      home: WelcomeScreen(),
    );
  }
}
