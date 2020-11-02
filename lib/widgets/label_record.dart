import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/text_styles.dart';

class LabelRecord extends StatelessWidget {
  final String labelName;
  final bool checked;

  const LabelRecord({Key key, @required this.labelName, this.checked = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: Duration(milliseconds: 100),
      scaleFactor: 1.5,
      onPressed: () {
        context.read<LabelProvider>().setActualLabel(labelName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: checked ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      AppConstants.labelName,
                      style: checked ? TextStyles.body.copyWith(color: Colors.white) : TextStyles.body,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      labelName,
                      style: checked ? TextStyles.body.copyWith(color: Colors.white) : TextStyles.body,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
