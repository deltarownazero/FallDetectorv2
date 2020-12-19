import 'dart:async';
import 'dart:convert';
import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/models/stats_entity.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/providers/stats_provider.dart';
import 'package:fall_detector/services/database.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';

import 'package:fall_detector/utils/text_styles.dart';

class AccDetails extends StatefulWidget {
  @override
  _AccDetailsState createState() => _AccDetailsState();
}

class _AccDetailsState extends State<AccDetails> {
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int _counter = AppConstants.accVerificationTime;

  double _sumX = 0;
  double _sumY = 0;
  double _sumZ = 0;
  Box<String> accBox;

  @override
  Widget build(BuildContext context) {
    final List<String> gyroscope = _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'X: ${_sumX.toStringAsFixed(3)}',
          style: TextStyles.body,
        ),
        Text(
          'Y: ${_sumY.toStringAsFixed(3)}',
          style: TextStyles.body,
        ),
        Text(
          'Z: ${_sumZ.toStringAsFixed(3)}',
          style: TextStyles.body,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    accBox = Hive.box<String>('acc_details');

    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];

        _sumX = _sumX + event.x.abs();
        _sumY = _sumY + event.y.abs();
        _sumZ = _sumZ + event.z.abs();
      });
    }));
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
      } else {
        saveData(_sumX, _sumY, _sumZ);
        sendDataToFirebase();
        setState(() {
          _sumX = 0;
          _sumY = 0;
          _sumZ = 0;
        });
        _counter = AppConstants.accVerificationTime;
      }
    });
  }

  void saveData(sumX, sumY, sumZ) async {
    bool saveData = context.read<StatsProvider>().actualStatus == AppConstants.play;
    int step = context.read<StatsProvider>().step;
    if (saveData) {
      var speed = context.read<StatsProvider>().actualSpeed;
      var label = context.read<LabelProvider>().actualLabel;
      var now = DateTime.now();
      StatsEntity statsEntity = StatsEntity(
          x: sumX,
          y: sumY,
          z: sumZ,
          sum: sumX + sumY + sumZ,
          label: label,
          step: step,
          send: false,
          speed: speed);
      await accBox.put(now.toString(), jsonEncode(statsEntity.toJson()));
    }
  }

  void sendDataToFirebase() async {
    bool sendData = context.read<StatsProvider>().needToSendData == true;
    if (sendData) {
      final user = Provider.of<AppUser>(context, listen: false);
      var email = user.email;

      var keys = accBox.keys;
      keys.forEach((key) async {
        print(accBox.get(key));
        var statsEntity = StatsEntity.fromJson(jsonDecode(accBox.get(key)));
        print(statsEntity);
        if (statsEntity.send == false) {
          await DatabaseService(mail: email).updateUserStats(
              statsEntity.label,
              statsEntity.speed,
              statsEntity.x,
              statsEntity.y,
              statsEntity.z,
              statsEntity.x + statsEntity.y + statsEntity.z,
              statsEntity.step);
        }
      });
      context.read<StatsProvider>().needToSendData = false;
    }
  }
}
