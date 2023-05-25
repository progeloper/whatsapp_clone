import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/common/delegates.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_phone_screen.dart';
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
      localizationsDelegates: Delegates.localizationDelegates,
      supportedLocales: Delegates.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Palette.backgroundColor,
      ),
      home: EnterPhoneScreen(),
    );
  }
}
