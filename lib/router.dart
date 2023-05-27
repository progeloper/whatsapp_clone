import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_phone_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/welcome_screen.dart';

final signedOutRoute = RouteMap(routes: {
  '/welcome-screen' : (_) => const MaterialPage(child: WelcomeScreen(),),
  '/enter-phone-screen': (_) =>const MaterialPage(child: EnterPhoneScreen()),
});

final signedInRoute = RouteMap(routes: {});