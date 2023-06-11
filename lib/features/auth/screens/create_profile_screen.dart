import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/core/common/widgets/number_text_field.dart';
import 'package:whatsapp_clone/core/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

import '../../../core/common/widgets/action_button.dart';
import '../../../theme/palette.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  final String number;
  const CreateProfileScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  Uint8List? file;

  void pickProfilePicture() async {
    file = await pickImage();
    setState(() {});
  }

  void saveDetails(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).saveUser(
        context: context,
        name: _usernameController.text,
        number: widget.number,
        about: _bioController.text,
        picture: file);
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(child: Container()),
                    Text(
                      'Create your profile',
                      style: TextStyle(
                          color: Palette.tabColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(child: Container()),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 20,
                          color: Palette.tabColor,
                        ),
                      ),
                    ),
                  ],
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
                  onTap: pickProfilePicture,
                  child: (file != null)
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: MemoryImage(file!),
                        )
                      : CircleAvatar(
                          radius: 100,
                          backgroundColor: Palette.extraLightGrey,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Palette.hintTextColor,
                            size: 80,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 40,
                ),
                InputTextField(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Type your username",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.hintTextColor,
                        letterSpacing: 1.0,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Palette.tabColor, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  child: TextField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      hintText: "Type a status",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.hintTextColor,
                        letterSpacing: 1.0,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Palette.tabColor, width: 2.0),
                      ),
                    ),
                  ),
                ),
                Flexible(child: Container()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ActionButton(
                    text: 'SAVE',
                    color: Palette.tabColor,
                    callback: () => saveDetails(context, ref),
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
