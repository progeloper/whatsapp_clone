import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/core/common/widgets/number_text_field.dart';

import '../../../core/common/widgets/action_button.dart';
import '../../../theme/palette.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({Key? key}) : super(key: key);

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  late TextEditingController _controller;
  ValueNotifier<String> selectedCountry = ValueNotifier('Nigeria');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(
            top: 32,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Verify your phone number',
                style: TextStyle(
                    color: Palette.tabColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.textColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: InputTextField(
                  child: Center(
                    child: ValueListenableBuilder(
                        valueListenable: selectedCountry,
                        builder: (context, t, c) {
                          return Text(
                            t,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: InputTextField(
                      child: CountryCodePicker(
                        onChanged: (country) {
                          selectedCountry.value = country.name!;
                        },
                        initialSelection: "NG",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: InputTextField(
                      child: TextField(
                        controller: _controller,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: "phone number",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Palette.hintTextColor,
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
              Flexible(
                child: Container(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ActionButton(
                  text: 'NEXT',
                  color: Palette.tabColor,
                  callback: () {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You must be ',
                  style: TextStyle(
                    color: Palette.hintTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'at least 16 years old ',
                      style: TextStyle(
                        color: Colors.blue[300],
                      ),
                    ),
                    TextSpan(
                      text: 'to register. Learn how WhatsApp works with the ',
                      style: TextStyle(
                        color: Palette.hintTextColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Facebook Companies.',
                      style: TextStyle(
                        color: Colors.blue[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
