import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/theme/palette.dart';

import '../../../core/common/widgets/number_text_field.dart';

class EnterOTPScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const EnterOTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends ConsumerState<EnterOTPScreen> {
  late TextEditingController _OTPController;

  @override
  void initState() {
    super.initState();

    _OTPController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _OTPController.dispose();
  }

  void goBack(BuildContext context) {
    Routemaster.of(context).pop();
  }

  void verifyOTP(WidgetRef ref, BuildContext context){
    ref.read(authControllerProvider.notifier).verifyOTP(context, widget.verificationId, _OTPController.text, widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Palette.appBarColor,
      //   leading: IconButton(
      //     onPressed: () => goBack(context),
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Palette.actionTextColor,
      //     ),
      //   ),
      //   title: Text(
      //     'Two-step Verification',
      //     style: TextStyle(
      //       color: Palette.actionTextColor,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0).copyWith(
            top: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify ${widget.phoneNumber}',
                style: TextStyle(
                  color: Palette.tabColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  text: 'Enter the code sent to ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Palette.textColor,
                  ),
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InputTextField(
                      child: TextField(
                        controller: _OTPController,
                        onChanged: (value){
                          if(value.length == 6){
                            verifyOTP(ref, context);
                          }
                        },
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(6),
                        // ],
                        decoration: InputDecoration(
                          hintText: "OTP Code",
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter 6-digit code',
                style: TextStyle(color: Palette.hintTextColor),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.chat,
                  color: Palette.tabColor,
                ),
                title: Text(
                  'Resend SMS',
                  style: TextStyle(
                    color: Palette.tabColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                onTap: () => goBack(context),
                leading: Icon(
                  Icons.phone_android,
                  color: Palette.tabColor,
                ),
                title: Text(
                  'Wrong number?',
                  style: TextStyle(
                    color: Palette.tabColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
