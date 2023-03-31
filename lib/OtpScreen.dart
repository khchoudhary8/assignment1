import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_database/firebase_database.dart';

class Otpscreen extends StatefulWidget {
  String phone, verifyid = '', smscode = '';
  int count = 0;

  Otpscreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 10);
  late TextEditingController pinController;
  TextEditingController resendController = TextEditingController();
  int remaining = 5;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    print(widget.phone);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      print("build Completed");

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone.toString(),
        verificationCompleted: (PhoneAuthCredential credential) {
          pinController.setText(credential.smsCode.toString());
          widget.smscode = credential.smsCode.toString();
          print(widget.smscode);
          print("SOOOOOLALAAAALLA");

        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          widget.verifyid = verificationId;
          print("HOOOOOOL:LLLLLLA");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},

      );
      startTimer();
    });
  }

  @override
  void dispose() {
    stopTimer();
    pinController.dispose();
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    widget.count = 0;
    stopTimer();
    setState(() => myDuration = Duration(seconds: 10));
    startTimer();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
        print(myDuration.inSeconds);
        if (seconds == 0) remaining = 5;
      }
    });
  }

  void resendOTP() {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone.toString(),
      verificationCompleted: (PhoneAuthCredential credential) {
        pinController.setText(credential.smsCode.toString());
        widget.smscode = credential.smsCode.toString();
        print(widget.smscode);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        widget.verifyid = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void addData(String uniqid) {
    print(widget.phone);
    ref.set({'phone': widget.phone, 'uid': uniqid});
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    var seconds = strDigits(myDuration.inSeconds.remainder(60));

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(70, 90, 127, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(214, 219, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                child: const Text("verfication",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 5),
              alignment: Alignment.topLeft,
              child: const Text("We have sent you a SMS code",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.purpleAccent)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 5),
              alignment: Alignment.topLeft,
              child: Text('on: ${widget.phone}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                controller: pinController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                // validator: (s) {
                //   return s == '222222' ? null : 'Pin is incorrect';
                // },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  print(pin);
                  widget.smscode = pin;
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    if (seconds == '00') {
                      widget.count = 0;
                      remaining = 5;
                      resetTimer();
                      resendOTP();
                      Fluttertoast.showToast(
                          msg: "SMS sent",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please wait",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text("resend sms : ${seconds}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C7C7C))),
                )),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () async {
                if (remaining <= 0) {
                  resetTimer();
                  Fluttertoast.showToast(
                      msg: "Too many wrong attempts, please wait 10 seconds.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verifyid,
                            smsCode: widget.smscode);
                    await auth.signInWithCredential(credential);
                    late User user = FirebaseAuth.instance.currentUser!;
                    ref = FirebaseDatabase.instance
                        .ref('users')
                        .child(user.uid.toString());
                    addData(user.uid.toString());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'Home1', (Route<dynamic> route) => false);
                  } catch (e) {
                    widget.count++;
                    remaining = 5 - widget.count;
                    Fluttertoast.showToast(
                        msg: "Incorrect OTP, Attempts left: ${remaining}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
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
                child: Text('Verify'),
              ),
            ),
          ],
        )));
  }
}
