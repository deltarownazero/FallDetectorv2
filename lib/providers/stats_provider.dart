import 'package:flutter/material.dart';
import 'package:fall_detector/utils/constants.dart';

class StatsProvider extends ChangeNotifier {
  String actualStatus = AppConstants.pause;
  double actualSpeed = 0;
  int step = 0;

  setActualStatus(String value) {
    actualStatus = value;
    notifyListeners();
  }

  setActualSpeed(double value) {
    actualSpeed = value;
    notifyListeners();
  }

  stepIncrease() {
    step++;
    notifyListeners();
  }

  stepReset() {
    step = 0;
    notifyListeners();
  }
}
