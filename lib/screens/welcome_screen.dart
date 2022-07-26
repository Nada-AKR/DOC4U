import 'package:doc4u/reusable_widgets/reusable_widget.dart';
import 'package:doc4u/screens/profile.dart';
import 'package:doc4u/screens/signin_screen.dart';
import 'package:doc4u/screens/signup_screen.dart';
import 'package:doc4u/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("FAD24D"),
          hexStringToColor("FAD351"),
          hexStringToColor("F9E39A")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: (Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                firebaseUIButton(context, "Log In", () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return SignInScreen();
                  }));
                }),
                firebaseUIButton(context, "Sign Up", () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return SignUpScreen();
                  }));
                }),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
