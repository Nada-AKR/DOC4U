import 'dart:ui';

import 'package:doc4u/screens/SideBar.dart';
import 'package:doc4u/screens/Visualization.dart';
import 'package:doc4u/screens/signin_screen.dart';
import 'package:doc4u/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  hexStringToColor("FAD24D"),
                  hexStringToColor("FAD351"),
                  hexStringToColor("F9E39A")
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                key: _globalKey,
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SideBar()));
                            },
                            icon: Icon(
                              Icons.menu_rounded,
                              size: 40,
                            ),
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              Image(
                                image: AssetImage('assets/images/logo.png'),
                                height: 70,
                                width: 63,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'DOC4U',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Hi ${user!.displayName}, Welcome!',
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                        height: height * 0.85,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                ),
                                Text(
                                  'Choose a function to focus on :',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Visualization()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 15, top: 15),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Visualization',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        Image(
                                          image: AssetImage(
                                              'assets/images/Visualisation.png'),
                                          height: 93,
                                          width: 230,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Visualization()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 15, top: 15),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Analyse',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        Image(
                                          image: AssetImage(
                                              'assets/images/Analyse.png'),
                                          height: 93,
                                          width: 230,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )))));
  }
}
