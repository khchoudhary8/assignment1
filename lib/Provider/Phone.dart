import 'package:flutter/cupertino.dart';

class Phone with ChangeNotifier {
  Phone({required this.phone});

  final String phone;


  void phonenumbertransfer() {
    notifyListeners();
  }
}

