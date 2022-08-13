import 'package:doc4u/screens/Settings.dart';
import 'package:doc4u/screens/aboutUs.dart';
import 'package:doc4u/screens/help.dart';
import 'package:doc4u/screens/profile.dart';
import 'package:doc4u/screens/signin_screen.dart';
import 'package:doc4u/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = user!.displayName.toString();
    final email = user!.email.toString();
    final photoURL =
        'https://cdna.artstation.com/p/assets/images/images/023/576/078/original/ying-chen-me-optimize.gif?1579652163';
    return Drawer(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("FAD24D"),
            hexStringToColor("FAD351"),
            hexStringToColor("F9E39A")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: ListView(
            children: <Widget>[
              buildHeader(
                  urlImage: photoURL,
                  name: name,
                  email: email,
                  onClicked: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Profile()));
                  }),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Profile',
                      icon: Icons.person,
                      onClicked: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Profile())),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Settings',
                      icon: Icons.settings_sharp,
                      onClicked: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Settings())),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'About',
                      icon: Icons.workspaces_outline,
                      onClicked: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AboutUs())),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Help',
                      icon: Icons.help_outline,
                      onClicked: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Help())),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout_outlined,
                      onClicked: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Back →',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black26;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
  }
}
