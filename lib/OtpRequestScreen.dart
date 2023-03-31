import 'package:assignment1/OtpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OtpReuest extends StatefulWidget {
  const OtpReuest({Key? key}) : super(key: key);

  @override
  State<OtpReuest> createState() => _OtpReuestState();
}

class _OtpReuestState extends State<OtpReuest> {
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  var ph;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                alignment: Alignment.topLeft,
                child: const Text("Welcome",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 5),
              alignment: Alignment.topLeft,
              child: const Text("Be Our Guest",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.purpleAccent)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 5),
              alignment: Alignment.topLeft,
              child: const Text("Enter your phone number",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black.withOpacity(0.13)),
                ),
                child: Stack(
                  children: [
                    InternationalPhoneNumberInput(
                      initialValue: number,
                      onInputChanged: (PhoneNumber number) {
                        ph = number.phoneNumber;
                        print(ph);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      // textFieldController: controller,
                      formatInput: false,
                      maxLength: 10,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      cursorColor: Colors.black,
                      inputDecoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 15, left: 0),
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                    Positioned(
                      left: 90,
                      top: 8,
                      bottom: 8,
                      child: Container(
                        height: 40,
                        width: 1,
                        color: Colors.black.withOpacity(0.13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 150),
            ElevatedButton(
              onPressed: () async {
                if (ph.toString().length < 13) {
                  Fluttertoast.showToast(
                      msg: "Enter a valid phone number",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Otpscreen(phone: ph.toString());
                  }));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Color(0xFF6D82EC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              child: const Padding(
                padding: EdgeInsets.all(19),
                child: Text('Continue'),
              ),
            ),
          ],
        )));
  }
}
