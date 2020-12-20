import 'dart:convert';

import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/models/stats_entity.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/providers/stats_provider.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';

class LocalDatabase {
  Box<String> accBox = Hive.box<String>('acc_details');

  void saveData(double sumX, double sumY, double sumZ, BuildContext context) async {
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

  void sendDataToFirebase(BuildContext context) async {
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
          await FirebaseService(mail: email).updateUserStats(
              statsEntity.label,
              statsEntity.speed,
              statsEntity.x,
              statsEntity.y,
              statsEntity.z,
              statsEntity.x + statsEntity.y + statsEntity.z,
              statsEntity.step);
          statsEntity.send = true;
          await accBox.put(key, jsonEncode(statsEntity.toJson()));
        }
      });
      context.read<StatsProvider>().needToSendData = false;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppConstants.dataSent)));
    }
  }

  Future<void> setFallLabels(BuildContext context) async {
    var keys = accBox.keys;
    var statsEntity = StatsEntity.fromJson(jsonDecode(accBox.get(keys.last)));
    if (statsEntity.step > AppConstants.fallStepLimit) {
      var lastKeys = [];
      for (int i = 0; i < AppConstants.fallStepLimit; i++) {
        var currentKey = keys.elementAt(AppConstants.fallStepLimit - i);
        lastKeys.add(currentKey);
        var statsEntity = StatsEntity.fromJson(jsonDecode(accBox.get(currentKey)));
        statsEntity.label = AppConstants.fallsLabel;
        await accBox.put(currentKey, jsonEncode(statsEntity.toJson()));
      }
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppConstants.fallReported)));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppConstants.notEnoughData)));
    }
  }
}
