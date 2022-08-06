import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc4u/reusable_widgets/reusable_widget.dart';
import 'package:doc4u/screens/profile.dart';
import 'package:doc4u/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final auth = FirebaseAuth.instance;
  User? user;
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        user!.updatePhotoURL(imageTemporary.toString());
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    setState(() {
      print("ProfileUpdate Picture uploaded");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ProfileUpdate Picture Uploaded')));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("FAD24D"),
          hexStringToColor("FAD351"),
          hexStringToColor("F9E39A")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  buildImage(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: buildEditIcon(Colors.transparent),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: height * 1,
              width: width * 0.8,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double innerHeight = constraints.maxHeight;
                  double innerWidth = constraints.maxWidth;
                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: innerHeight,
                        width: innerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '${user!.displayName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 24),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${user!.email}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 24),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            firebaseUIButton(context, "OK", () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return Profile();
                              }));
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: image != null
            ? ClipOval(
                child: Image.file(
                image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ))
            : Image.network(
                'https://www.pngitem.com/pimgs/m/20-203432_ProfileUpdate-icon-png-image-free-download-searchpng-ville.png',
                height: 130,
              ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.transparent,
        all: 3,
        child: buildCircle(
          color: color,
          all: 0,
          child: IconButton(
            onPressed: () {
              pickImage();
              userSetup(image!);
              user!.updatePhotoURL(image.toString());
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 20,
            ),
          ),
        ),
      );
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

Future<void> userSetup(File photoURL) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  String uid = auth.currentUser!.uid.toString();

  users.add({
    'Image': photoURL,
    uid: uid,
  });

  return;
}
