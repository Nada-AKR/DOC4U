import 'package:doc4u/main.dart';
import 'package:doc4u/screens/welcome_screen.dart';
import 'package:doc4u/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 10000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("FAD24D"),
          hexStringToColor("FAD351"),
          hexStringToColor("F9E39A")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 0.0),
                  child: Image(image: AssetImage("assets/images/logo.png")),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'DOC4U',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  'Tense Yet Sweet',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
