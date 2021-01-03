import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/login_screen.dart';
import 'package:flutter_app/screens/main_screen/main_screen.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? LoginScreen()
        : MainScreen();
  }
}
