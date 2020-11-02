import 'dart:async';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/text_styles.dart';

class TimeWidget extends StatefulWidget {
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  int _counter = 0;
  Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  void _pauseTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _stopTimer() {
    setState(() {
      _counter = 0;
    });
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 20),
              child: Text(
                AppConstants.time,
                style: TextStyles.headingMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                '$_counter.00 s',
                style: TextStyles.headingMedium.copyWith(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: _startTimer,
                child: Icon(
                  Icons.play_circle_outline_rounded,
                  size: 80,
                  color: AppColors.primaryColor,
                ),
              ),
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: _pauseTimer,
                child: Icon(
                  Icons.pause_circle_outline_outlined,
                  size: 80,
                  color: AppColors.primaryColor,
                ),
              ),
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: _stopTimer,
                child: Icon(
                  Icons.stop_circle_outlined,
                  size: 80,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
