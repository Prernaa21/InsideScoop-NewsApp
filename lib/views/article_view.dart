import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_performance/firebase_performance.dart';

class Articleview extends StatefulWidget {
  final String title;
  final String blogUrl;
  Articleview({this.blogUrl, String imageUrl, this.title});
  @override
  _ArticleviewState createState() => _ArticleviewState();
}

class _ArticleviewState extends State<Articleview> {



  final Completer<WebViewController> _controller = Completer<
      WebViewController>();
  bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Inside",
                  style:
                  GoogleFonts.pacifico(
                      color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Scoop",
                  style: GoogleFonts.pacifico(
                      color: Colors.red[900], fontWeight: FontWeight.w600),
                )
              ],
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),

              )],
            backgroundColor: themeColors(),
            elevation: 0.0,
          ),
          body: Container(
            color: themeColors(),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: WebView(
              initialUrl: widget.blogUrl,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              }
            ),
          ),
        );
  }}