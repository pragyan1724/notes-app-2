import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/controller/google_auth.dart';
import 'package:mynotes/pages/homepage.dart';
import 'package:mynotes/pages/login.dart';
import 'package:mynotes/pages/login.dart';
class checking extends StatefulWidget {
  @override
  _checkingState createState() => _checkingState();
}

class _checkingState extends State<checking> {
  @override
  User firebaseUser;
  void initsState(){
    super.initState();
    assign(FirebaseAuth.instance.currentUser);
  }
  void assign(UserCredential) async{
    setState(() {
      firebaseUser= UserCredential;
    });
  }
 @override
  Widget build(BuildContext context) {
    if(firebaseUser!= null)
      return HomePage();
    else
      return LoginPage();
  }
}
