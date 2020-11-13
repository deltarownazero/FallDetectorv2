import 'package:fall_detector/services/auth.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/widgets/primary_button.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: AppConstants.login),
                    onChanged: (val) {},
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: AppConstants.password),
                      obscureText: true,
                      onChanged: (val) {},
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: PrimaryButton(
              text: AppConstants.signIn,
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result != null) {
                  print('signed in');
                  print(result.uid);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
