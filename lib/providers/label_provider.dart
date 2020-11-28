import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class LabelProvider extends ChangeNotifier {
  String actualLabel = AppConstants.testLabel;
  List<String> chartLabels = new List();

  void setActualLabel(String value) {
    actualLabel = value;
    notifyListeners();
  }

  void addLabelToChartList(String value, Box<String> accBox) {
    chartLabels.add(value);
    accBox.put(value, AppConstants.labelActive);
    notifyListeners();
  }

  void deleteLabelFromChartList(String value, Box<String> accBox) {
    chartLabels.remove(value);
    accBox.put(value, AppConstants.labelInactive);
    notifyListeners();
  }

  List<String> getChartLabelsFromHive(Box<String> accBox) {
    chartLabels = [];
    accBox.keys.forEach((label) {
      if (accBox.get(label) == AppConstants.labelActive) chartLabels.add(label);
    });
    return chartLabels;
  }
}
