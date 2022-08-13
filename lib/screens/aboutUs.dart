import 'package:doc4u/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
            child: Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 100,
                ),
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 70,
                  width: 120,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'DOC4U',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              height: height * 0.35,
              child: Image(
                image: AssetImage("assets/images/aboutus.png"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'About Us',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'DOC4U ensures the collection and visualization of your health data.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'This mobile application was developed by AKKARI Nada , a student at SUPCOM as part of an engineering internship at the startup TAC TIC.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        )),
      ),
    ));
  }
}
