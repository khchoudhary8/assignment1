import 'package:assignment1/OtpRequestScreen.dart';
import 'package:flutter/material.dart';

class MyWelcome extends StatefulWidget {

   MyWelcome({Key? key}) : super(key: key);

  @override
  _MyWelcomeState createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin:
                const EdgeInsets.only(left: 3, right: 3, top: 0, bottom: 0),
                height: 380,
                padding: const EdgeInsets.all(30),
                // decoration: const BoxDecoration(
                //   color: Colors.purpleAccent,
                //   borderRadius: BorderRadiusDirectional.only(
                //       topStart: Radius.zero,
                //       topEnd: Radius.zero,
                //       bottomStart: Radius.circular(30),
                //       bottomEnd: Radius.circular(30)),
                // ),
                // didn't like the card output so commented
                alignment: Alignment.center,
                child: Image.asset('assets/grocery.jpg')),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'We deliver',
                      style: TextStyle(
                          fontSize: 34, fontWeight: FontWeight.w700),
                    ), SizedBox(width: 1,),
                    const Text(
                      "grocery at your",
                      style: TextStyle(fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.purpleAccent),
                    ),
                    const Text(
                      "doorsteps",
                      style: TextStyle(
                          fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 50),

                    const Text(
                      "Grocerr gives you fresh vegetables and fruits,",
                      style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(
                              0xFF8D8D8D)),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      "Order fresh items from Grocerr",
                      style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(
                              0xFF8D8D8D)),
                    ),
                    const SizedBox(height: 70,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context)
                            { return OtpReuest();
                            }));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(19),
                        child: Text('Get started'),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Color(0xFF6D82EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),),
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
