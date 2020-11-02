import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

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
    return MaterialApp(
      title: AppConstants.nameApp,
      theme: ThemeData(primarySwatch: AppColors.primaryColor, accentColor: AppColors.primaryColorAccent),
      home: HomeScreen(),
    );
  }
}
