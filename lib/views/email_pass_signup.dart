import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailPassSignup extends StatefulWidget {
  @override
  _EmailPassSignupState createState() => _EmailPassSignupState();
}

class _EmailPassSignupState extends State<EmailPassSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _database = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Email Sign-In"),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("android/app/src/main/res/drawable/ls.png"),
          fit: BoxFit.fill,
        )),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(35),
                margin: EdgeInsets.only(top: 180),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
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
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "Password",
                    hintText: "Enter Password Here",
                  ),
                  obscureText: true,
                )),
            InkWell(
              onTap: () {
                _signup();
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.white, Colors.white]),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                    child: Text(
                  "Signup Using Email",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() {
    final String emailTXT = _emailController.text.trim();
    final String passwordTXT = _passwordController.text.trim();
    if (emailTXT.isNotEmpty && passwordTXT.isNotEmpty) {
      _auth
          .createUserWithEmailAndPassword(
              email: emailTXT, password: passwordTXT)
          .then((user) {
        _database.collection("users").document(user.user.uid).setData({
          "email": emailTXT,
          "lastonline": DateTime.now(),
          "signin_method": user.user.providerData
        });

        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text("Success!"),
                  content:
                      Text("Sign Up process completed, now you can sign in."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("OK"),
                      style: TextButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
            }).catchError((e) {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text("Error⚠"),
                    content: Text("${e.message}"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
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
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Error⚠"),
                content: Text("Please provide email and password"),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
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
  }
}
