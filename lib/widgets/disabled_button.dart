import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisabledButton extends StatefulWidget {
  final String text;
  const DisabledButton({Key key, this.text}) : super(key: key);

  @override
  _DisabledButtonState createState() => _DisabledButtonState();
}

class _DisabledButtonState extends State<DisabledButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 48,
        decoration: ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyles.headingMedium.copyWith(color: AppColors.lightGrey),
          ),
        ),
      ),
    );
  }
}
