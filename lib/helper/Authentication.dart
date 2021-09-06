import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insidescoop/views/home.dart';
import 'package:insidescoop/views/login_screen.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser != null){
      return Home();
    }
    else {
      return LoginScreen();
    }

  }
}
