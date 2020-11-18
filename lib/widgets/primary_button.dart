import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String text;
  const PrimaryButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BouncingWidget(
        duration: Duration(milliseconds: 100),
        scaleFactor: 1.5,
        onPressed: widget.onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyles.headingMedium.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
