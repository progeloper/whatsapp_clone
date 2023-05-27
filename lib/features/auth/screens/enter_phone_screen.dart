import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../theme/palette.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({Key? key}) : super(key: key);

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16).copyWith(
              top: 32,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Verify your phone number',
                  style: TextStyle(
                    color: Palette.tabColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 30,),
                Text(
                  'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.textColor,
                    fontSize: 15,
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
