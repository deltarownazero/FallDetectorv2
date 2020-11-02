import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/widgets/label_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> labels = AppConstants.labelsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          AppConstants.settings,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (BuildContext context, int index) {
          return LabelRecord(
            labelName: labels[index],
            checked: labels[index] == context.watch<LabelProvider>().actualLabel,
          );
        },
      ),
    );
  }
}
