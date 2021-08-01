import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';


class PhoneSignIn extends StatefulWidget {

  @override
  _PhoneSignInState createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  PhoneNumber _phoneNumber;

  String _message;
  String _verificationId;
  bool _isSMSsent = false;

  final FirebaseAuth _auth =  FirebaseAuth.instance;
  final TextEditingController _smsController = TextEditingController();
  final Firestore _database = Firestore.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
         Text("Phone Sign-In"),
      ],),),
      body: AnimatedContainer(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("android/app/src/main/res/drawable/ls.png"),
                  fit: BoxFit.fill,
                )),
          duration: Duration(microseconds: 500),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(top: 180),

              child: InternationalPhoneNumberInput(

                onInputChanged: (phoneNumberTxt) {
                  _phoneNumber = (phoneNumberTxt);
                },
                inputBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0)
                ),
                initialCountry2LetterCode: 'IN',
              ),
            ),

            _isSMSsent?Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                cursorColor: Colors.black,
                controller: _smsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0)
                  ),
                  hintText: "OTP here",
                  labelText: "OTP"
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,

              ),
            )
            : Container(),

            !_isSMSsent?InkWell(
              onTap: () {
                setState(() {
                  _isSMSsent = true;
                });

                _verifyPhoneNumber();
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
                    ),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(child: Text(
                  "Send OTP", style: TextStyle(color: Colors.black),)),
              ),
            ): InkWell(
              onTap: () {
               _signInWithPhoneNumber();
               Navigator.push(context, MaterialPageRoute(
                   builder: (context) => Home())
               );
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
                )
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(child: Text(
                  "Verify OTP", style: TextStyle(color: Colors.black),)),
              ),
            ),
          ],
        ),
      ),
      );
  }

  void _verifyPhoneNumber () async{
    setState(() {
      _message="";
    });

    final PhoneVerificationCompleted verificationCompleted =
    (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message ="Received phone auth credential: $phoneAuthCredential";
      });
    };

    final PhoneVerificationFailed verificationFailed=
    (AuthException authException) {
      setState(() {
        _message ="Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}";
      });
    };

    final PhoneCodeSent codeSent =
    (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
    (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(phoneNumber: _phoneNumber.phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user =
    (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser =  await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {

        _database.collection("users").document(user.uid).setData({
          "phoneNumber": user.phoneNumber,
          "lastonline": DateTime.now(),
          "signin_method": user.providerId
        });
        _message = "Successfully signed in!, vid: " + user.uid;
      }
      else {
        _message = "Sign in failed";
      }
    });
  }
}
