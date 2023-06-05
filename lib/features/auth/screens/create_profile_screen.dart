import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/core/constants/constants.dart';

import '../../../theme/palette.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0).copyWith(
              top: 32.0,
              bottom: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create your profile',
                  style: TextStyle(
                      color: Palette.tabColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Help your contacts identify you',
                  style: TextStyle(
                      color: Palette.darkGreyColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Palette.lightGreyColor,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Palette.hintTextColor,
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
