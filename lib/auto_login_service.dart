import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/products_screen.dart';
import 'screens/login_screen.dart';

class AutoLoginService {
  void isLogin(BuildContext context) {
    final FirebaseAuth checkIfLogin = FirebaseAuth.instance;
    final _userDetail = checkIfLogin.currentUser;

    if (_userDetail != null) {
      Timer(
        Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(),
            ),
          );
          debugPrint(
              'splash_services.dart == User already logged in. User email: ${_userDetail.email}');
          debugPrint('== Navigating to products_screen.dart');
        },
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
          debugPrint('== Navigating to login_screen.dart');
        },
      );
    }
  }
}
