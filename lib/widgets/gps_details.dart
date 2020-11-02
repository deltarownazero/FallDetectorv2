import 'package:fall_detector/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';

class GpsDetails extends StatelessWidget {
  final String title;
  final String value;

  const GpsDetails({Key key, this.title, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyles.body,
              ),
            ],
          ),
        ),
        Positioned(
          left: 100,
          bottom: 10,
          child: Text(
            value,
            style: TextStyles.body,
          ),
        ),
      ],
    );
  }
}
