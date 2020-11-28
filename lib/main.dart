import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/screens/authenticate.dart';
import 'package:fall_detector/services/auth.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>('acc');
  await Firebase.initializeApp();
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
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: AppConstants.nameApp,
        theme:
            ThemeData(primarySwatch: AppColors.primaryColor, accentColor: AppColors.primaryColorAccent),
        home: Authenticate(),
      ),
    );
  }
}
