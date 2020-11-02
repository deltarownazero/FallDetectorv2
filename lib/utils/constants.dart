class AppConstants {
  AppConstants._();

  static const nameApp = 'Fall Detector';
  static const actualLabel = 'Actual label: ';
  static const unknown = 'Unknown';
  static const location = 'Location:';
  static const speed = 'Speed:';
  static const distance = 'Distance:';
  static const time = 'Time:';
  static const settings = 'Settings';
  static const labelName = 'Label name:';
  static const labels = 'Labels:';
  static const details = 'Details';
  static const addChart = 'Add chart';
  static const pleaseChooseLabel = 'Please choose label to compare';
  static const reportFall = 'Report fall';
  static const fallReported = 'Fall reported!';

  static const walkLabel = 'Walk';
  static const trainLabel = 'Train';
  static const fallsLabel = 'Falls';
  static const casualDayLabel = 'Casual day';
  static const joggingLabel = 'Jogging';
  static const sittingOnChairLabel = 'Sitting on chair';
  static const testLabel = 'Test';

  static const save = 'Save';
  static const cancel = 'Cancel';

  static const List<String> labelsList = [
    AppConstants.testLabel,
    AppConstants.walkLabel,
    AppConstants.trainLabel,
    AppConstants.fallsLabel,
    AppConstants.casualDayLabel,
    AppConstants.joggingLabel,
    AppConstants.sittingOnChairLabel,
  ];

  static const distanceVerificationTime = 5;
  static const accVerificationTime = 3;
}
