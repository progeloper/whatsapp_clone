import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/common/widgets/action_button.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            top: 32,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  color: Palette.textColor,
                  fontSize: 20,
                ),
              ),
              Flexible(
                child: Container(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.asset(
                  'assets/bg.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Flexible(child: Container()),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Tap "Agree and continue" to accept the ',
                  style: TextStyle(
                    color: Palette.textColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'WHatsApp Terms of Service and Privacy Policy',
                      style: TextStyle(
                        color: Palette.messageColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: ActionButton(text: 'AGREE AND CONTINUE', color: Palette.tabColor, callback: () {},),
              )
            ],
          ),
        ),
      ),
    );
  }
}
