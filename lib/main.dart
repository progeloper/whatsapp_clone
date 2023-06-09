import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/core/common/delegates.dart';
import 'package:whatsapp_clone/core/common/loading_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/enter_phone_screen.dart';
import 'package:whatsapp_clone/router.dart';
import 'package:whatsapp_clone/theme/palette.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

import 'core/common/error_text.dart';
import 'features/auth/controller/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: TheApp()));
}


class TheApp extends ConsumerStatefulWidget {
  const TheApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TheAppState();
}

class _TheAppState extends ConsumerState<TheApp> {
  model.User? userModel;
  int ctr = 0;

  void getData(WidgetRef ref, User user) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;
    ref.watch(userProvider.notifier).update((state) => userModel);
    if (ctr == 0) {
      ctr++;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (data) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Palette.backgroundColor,
        ),
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) {
            if (data != null) {
              getData(ref, data);
              if(userModel != null){
                return signedInRoute;
              }
            }
            return signedOutRoute;
          },
        ),
        routeInformationParser: const RoutemasterParser(),
      ),
      error: (err, stack) => ErrorText(error: err.toString()),
      loading: () => const LoadingScreen(),
    );
  }
}
