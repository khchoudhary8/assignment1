import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeActivity extends StatefulWidget {


  HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late String currentUId, phone="";
  late DatabaseReference  ref;
  late User user;
  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    currentUId = user.uid;
    phone = user.phoneNumber!;
    print(currentUId);
     ref= FirebaseDatabase.instance.ref('users').child(currentUId);
      // addData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: [

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  alignment: Alignment.topLeft,
                  child: const Text("Hello Grocerr User!",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.purpleAccent)),
                ),
                const SizedBox(height: 80),
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 5),
                  alignment: Alignment.center,
                  child:  Text(phone,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const SizedBox(height: 130),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'Welcome1', (Route<dynamic> route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Color(0xFF6D82EC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  child: const Padding(
                    padding: EdgeInsets.all(19),
                    child: Text('Logout'),
                  ),
                ),
              ],
            )));
  }
}
