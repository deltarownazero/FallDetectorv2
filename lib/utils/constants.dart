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
  static const label = 'Label:';
  static const details = 'Details';
  static const addChart = 'Add chart';
  static const pleaseChooseLabel = 'Please choose label to compare';
  static const reportFall = 'Report fall';
  static const sendData = 'Send data';
  static const fallReported = 'Fall reported!';
  static const dataSent = 'Data sent to firebase!';
  static const notEnoughData = 'Not enough data to report fall';

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
    AppConstants.casualDayLabel,
    AppConstants.joggingLabel,
    AppConstants.sittingOnChairLabel,
  ];

  static const distanceVerificationTime = 5;
  static const accVerificationTime = 3;

  static const login = 'Login';
  static const signIn = 'Sign in';
  static const password = 'Password';
  static const emptyEmail = 'Email cannot be empty';
  static const emptyPassword = 'Password cannot be empty';
  static const invalidEmailMsg = 'Please enter a valid email address';
  static const welcome = 'Welcome!';
  static const pleaseSignIn = 'Please sign in to continue';
  static const firstTime = 'If this is your first time, registration will be automatic';
  static const passwordToShort = 'Password should be at least 6 characters';

  static const play = "Play";
  static const pause = "Pause";
  static const stop = "Stop";

  static const labelActive = 'active';
  static const labelInactive = 'inactive';
  static const firebaseStatsLimit = 30;
  static const fallStepLimit = 7;
}
