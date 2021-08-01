import 'package:flutter/material.dart';
import 'package:insidescoop/views/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insidescoop/views/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
              ), nextScreen: LoginScreen(),
    backgroundColor: Colors.white,
    duration: 2000,));

    }
  }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot){
          if(snapshot.hasData) {
            FirebaseUser user = snapshot.data;
            if(user != null) {
             return Home();
          }
            else {
             return LoginScreen();
            }
          }
          return LoginScreen();
        },
      ),
    );
  }
}

