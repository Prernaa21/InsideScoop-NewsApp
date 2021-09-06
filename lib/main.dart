import 'package:flutter/material.dart';
import 'package:insidescoop/views/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insidescoop/views/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:insidescoop/helper/Authentication.dart';

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'InsideScoop',
          
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.redAccent
        ),
        home:
        AnimatedSplashScreen(
          splash: Container(
                    child: Column(
                    children: <Widget>[
                      Text(
                        "InsideScoop📰",
                        style: GoogleFonts.pacifico(
                          color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 20),
                      ) ,

                      Text(
                        "A Click Away!",
                        style: GoogleFonts.indieFlower(color: Colors.red[900], fontWeight: FontWeight.w600, fontSize: 24),
                      )
                    ],
                  )
              ), nextScreen: Authenticate(),
    backgroundColor: Colors.white,
    duration: 2000,));

    }
  }

