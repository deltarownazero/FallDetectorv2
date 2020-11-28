import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/services/database.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/widgets/chart_widget.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> labels = new List();
  List<String> actualLabels;
  Box<String> accBox;
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    accBox = Hive.box<String>('acc');
  }

  @override
  Widget build(BuildContext context) {
    getLabels();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          AppConstants.details,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String label in actualLabels)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ChartWidget(
                    labelName: label,
                    accBox: accBox,
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text(AppConstants.pleaseChooseLabel),
                        content: DropdownButton<String>(
                          value: dropdownValue,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: AppColors.primaryColor),
                          underline: Container(
                            height: 2,
                            color: AppColors.primaryColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: getDropDownItemList(),
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(AppConstants.cancel)),
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<LabelProvider>().addLabelToChartList(dropdownValue, accBox);
                              },
                              child: Text(AppConstants.save)),
                        ],
                      );
                    },
                  ));
        },
        tooltip: AppConstants.addChart,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownItemList() {
    List<DropdownMenuItem<String>> items = List();
    for (String label in labels) {
      items.add(
        DropdownMenuItem(
          child: Text(label),
          value: label,
        ),
      );
    }
    return items;
  }

  void getLabels() {
    actualLabels = context.watch<LabelProvider>().getChartLabelsFromHive(accBox);
    labels = [];
    for (String label in AppConstants.labelsList) labels.add(label);
    for (String label in actualLabels) {
      labels.remove(label);
    }
    labels.remove(AppConstants.fallsLabel);
    dropdownValue = labels.first;
  }
}
