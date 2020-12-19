import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:fall_detector/utils/text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final double width;

  const SecondaryButton({Key key, @required this.onPressed, @required this.text, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BouncingWidget(
        duration: Duration(milliseconds: 100),
        scaleFactor: 1.5,
        onPressed: onPressed,
        child: Container(
          height: 48,
          width: width,
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(color: AppColors.primaryColor),
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.headingMedium.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
