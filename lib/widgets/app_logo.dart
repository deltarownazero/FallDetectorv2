import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/details_screen.dart';

class AppLogo extends StatefulWidget {
  @override
  _AppLogoState createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> spin;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 3500), vsync: this);
    spin = Tween<double>(begin: 0, end: 4)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }

  @override
  Widget build(BuildContext context) {
    controller?.repeat();

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
        child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                  angle: spin.value * 3.141516,
                  child: Icon(
                    Icons.phone_iphone_rounded,
                    color: Colors.white,
                    size: 50,
                  ));
            }),
      ),
    );
  }
}
