import 'package:flutter/material.dart';
import 'package:mynotes/controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              child: Text(
                "login to continue",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Google sign-in",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    //
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    )),
              ),
            ),
            //
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}