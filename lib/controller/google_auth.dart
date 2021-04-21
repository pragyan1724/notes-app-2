import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mynotes/pages/homepage.dart';
bool signincheck=false;
GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential authResult =
      await auth.signInWithCredential(credential);
      final User user = authResult.user;
      var userData = {
        'name': googleSignInAccount.displayName,
        'email': googleSignInAccount.email,
      };

      users.doc(user.uid).get().then((doc) {
        if (doc.exists) {
          signincheck=true;
          doc.reference.update(userData);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
        else {
          signincheck=true;
          users.doc(user.uid).set(userData);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      }
      );
    }
  } catch (PlatformException) {
    print(PlatformException);
    print("Sign in not successful !");
  }
}
Future<void> signOutUser() async {
  await googleSignIn.disconnect();
  await auth.signOut();
  signincheck=false;
}