import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/features/auth/screens/create_profile_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_phone_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/welcome_screen.dart';

final signedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: WelcomeScreen(),
      ),
  '/enter-phone-screen': (_) => const MaterialPage(child: EnterPhoneScreen()),
  '/enter-otp-screen/:verificationId/:mobile': (route) => MaterialPage(
        child: EnterOTPScreen(
          verificationId: route.pathParameters['verificationId']!,
          phoneNumber: route.pathParameters['mobile']!,
        ),
      ),
  '/create-profile-screen':(_)=> const MaterialPage(child: CreateProfileScreen()),
});

final signedInRoute = RouteMap(routes: {});
