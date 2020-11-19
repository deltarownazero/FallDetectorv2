import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/screens/home_screen.dart';
import 'package:fall_detector/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    if (user == null)
      return SignIn();
    else
      return HomeScreen();
  }
}
