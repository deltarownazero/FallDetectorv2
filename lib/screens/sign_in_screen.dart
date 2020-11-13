import 'package:fall_detector/services/auth.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/widgets/primary_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.nameApp,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: PrimaryButton(
              text: 'Sign in',
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result != null) {
                  print('signed in');
                  print(result);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
