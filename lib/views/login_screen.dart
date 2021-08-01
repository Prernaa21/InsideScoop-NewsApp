import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insidescoop/views/email_pass_signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insidescoop/views/phone_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _database = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("android/app/src/main/res/drawable/s.png"),
          fit: BoxFit.fill,
        )),
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.only(bottom: 0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                "InsideScoop📰",
                style: GoogleFonts.pacifico(
                    color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 30),
              ) ,

              ),
            Container(
                margin: EdgeInsets.only(top: 80,),
                child: Text("Login",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25)

                  ),),

            Container(
                padding: EdgeInsets.all(35),
                margin: EdgeInsets.only(top: 40),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(28.0),
                    ),
                    labelText: "Email",
                    hintText: "Enter Email Here",
                  ),
                  keyboardType: TextInputType.emailAddress,
                )),

            Container(
                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(28.0),
                    ),
                    labelText: "Password",
                    hintText: "Enter Password Here",
                  ),
                  obscureText: true,
                )),


            InkWell(
              onTap: () {
                _signIn();

              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.white70,
                          Colors.white70
                        ]
                    ),
                    borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                color: Colors.black,
                  width: 1,
                )),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(child: Text(
                  "Login", style: TextStyle(color: Colors.black),)),
              ),
            ),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EmailPassSignup()
              ));
            },
              child: Text("Sign-Up",  style: TextStyle(
                  color: Colors.black
              ),),),

            Container(
              margin: EdgeInsets.only(top: 30,),
              child: Wrap(
                children: <Widget>[
                  TextButton.icon(onPressed: () {
                    _signInUsingGoogle();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Home())
                    );
                  },
                    icon: Icon(FontAwesomeIcons.google, color: Colors.black,),
                    label: Text("", style: TextStyle(
                        color: Colors.black
                    ),),),

                  TextButton.icon(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PhoneSignIn()
                    ));
                  },
                    icon: Icon(Icons.phone, color: Colors.black),
                    label: Text("", style: TextStyle(
                        color: Colors.black
                    ),),),
                ],
              ),
            )

          ],),
      ),


    );
  }

  void _signIn() async {
    
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    
    if(email.isNotEmpty && password.isNotEmpty) {
      _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((user) {

        _database.collection("users").document(user.user.uid).setData({
          "email": email,
          "lastonline": DateTime.now(),
          "signin_method": user.user.providerId
        });


        showDialog(context: context,
            builder: (ctx) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text("Done"),
                  content: Text("Sign in Success!"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancel"),
              style: TextButton.styleFrom(
              primary: Colors.redAccent,
                    ), onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Home())

                      );
              },
                    )]);
            })
            .catchError((e) {
          showDialog(context: context,
              builder: (ctx) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text("Error⚠"),
                    content: Text("${e.message}"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancel"),
                        style: TextButton.styleFrom(
                          primary: Colors.redAccent,
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ]);
              });
        });
      });
    } else{
      showDialog(context: context,
          builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Error⚠"),
            content: Text("Please provide email and password."),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                child: Text("OK"),
                style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  _emailController.text = "";
                  _passwordController.text = "";

                  Navigator.of(ctx).pop();
                },
              )
            ]);
          });
    }}

 _signInUsingGoogle() async {
   try {
     final GoogleSignInAccount googleUser = await  _googleSignIn.signIn();

     final GoogleSignInAuthentication googleAuth = await googleUser
         .authentication;

     final AuthCredential credential = GoogleAuthProvider.getCredential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
     print("signed in" + user.displayName);

     if (user != null) {
       _database.collection("users").document(user.uid).setData({
         "displayName": user.displayName,
         "email": user.email,
         "photo": user.photoUrl,
         "lastonline": DateTime.now(),
         "signin_method": user.providerId
       });
     }

     return await FirebaseAuth.instance.signInWithCredential(credential);
 }
   catch (e) {
     showDialog(context: context,
         builder: (ctx) {
           return AlertDialog(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16),
               ),
               title: Text("Error⚠"),
               content: Text("${e.message}"),
               actions: <Widget>[
                 TextButton(
                   child: Text("Cancel"),
                   style: TextButton.styleFrom(
                     primary: Colors.redAccent,
                   ),
                   onPressed: () {
                     Navigator.of(ctx).pop();
                   },
                 ),
               ]);
         });
   }
 }}