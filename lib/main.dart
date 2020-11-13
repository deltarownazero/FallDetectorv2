import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/screens/sign_in_screen.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LabelProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: AppConstants.nameApp,
              theme: ThemeData(
                  primarySwatch: AppColors.primaryColor, accentColor: AppColors.primaryColorAccent),
              home: SignIn(),
            );
          }
          return Container();
        });
  }
}
