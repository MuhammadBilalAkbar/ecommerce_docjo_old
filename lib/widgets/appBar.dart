import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/utils.dart';
import '../screens/login_screen.dart';
AppBar appBar({
  required BuildContext context,
  required String text,
}) {
  final FirebaseAuth logOutAuth = FirebaseAuth.instance;
  return AppBar(
    title:  Text(text),
    actions: [
      IconButton(
        onPressed: () {
          logOutAuth.signOut().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
            debugPrint('== Navigating to login_screen.dart');
          }).onError((error, stackTrace) {
            Utils().showToastMessage(error.toString());
          });
          debugPrint(
              '== Signing out user ${logOutAuth.currentUser!.email}');
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}