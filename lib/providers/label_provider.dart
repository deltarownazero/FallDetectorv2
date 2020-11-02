import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class LabelProvider extends ChangeNotifier {
  String actualLabel = AppConstants.testLabel;
  List<String> chartLabels = new List();

  void setActualLabel(String value) {
    actualLabel = value;
    notifyListeners();
  }

  void addLabelToChartList(String value) {
    chartLabels.add(value);
    notifyListeners();
  }

  void deleteLabelFromChartList(String value) {
    chartLabels.remove(value);
    notifyListeners();
  }
}
