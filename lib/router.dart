import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/features/auth/screens/create_profile_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_phone_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/welcome_screen.dart';
import 'package:whatsapp_clone/features/contacts/screens/contacts_screen.dart';
import 'package:whatsapp_clone/features/home/screens/home_screen.dart';

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
  '/create-profile-screen/:mobile': (route) => MaterialPage(
        child: CreateProfileScreen(
          number: route.pathParameters['mobile']!,
        ),
      ),
});

final signedInRoute = RouteMap(routes: {
  '/': (_)=> const MaterialPage(child: HomeScreen()),
  '/contacts-screen':(_)=> const MaterialPage(child: ContactsScreen()),
});
