import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details_screen.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: Duration(milliseconds: 100),
      scaleFactor: 1.5,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(200)),
        ),
        height: 90,
        width: 90,
        child: Roulette(
          infinite: true,
          child: Icon(
            Icons.phone_iphone_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
