import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/features/auth/screens/welcome_screen.dart';

final signedOutRoute = RouteMap(routes: {
  '/welcome-screen' : (_) => const MaterialPage(child: WelcomeScreen(),),

});

final signedInRoute = RouteMap(routes: {});