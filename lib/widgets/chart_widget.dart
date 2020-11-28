import 'package:bezier_chart/bezier_chart.dart';
import 'package:fall_detector/models/app_user.dart';
import 'package:fall_detector/models/stats_entity.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/services/database.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ChartWidget extends StatelessWidget {
  final String labelName;
  final Box<String> accBox;

  const ChartWidget({Key key, this.labelName, this.accBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataPoint> dataX = [];
    List<DataPoint> dataY = [];
    List<DataPoint> dataZ = [];
    List<DataPoint> dataSum = [];
    List<DataPoint> dataSpeed = [];
    final user = Provider.of<AppUser>(context, listen: false);
    var email = user.email;
    List<double> xAxisCustomValues = [];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        AppConstants.label,
                        style: TextStyles.body,
                      ),
                    ),
                    Text(labelName, style: TextStyles.body.copyWith(color: AppColors.primaryColor)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<LabelProvider>().deleteLabelFromChartList(labelName, accBox);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<List<StatsEntity>>(
              future: DatabaseService(mail: email).getStatsFromFirebase(labelName),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Container(height: 200, child: Text("Something went wrong")));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var step = 1.0;
                  snapshot.data.forEach((stats) {
                    dataX.add(DataPoint<double>(value: stats.x, xAxis: step));
                    dataY.add(DataPoint<double>(value: stats.y, xAxis: step));
                    dataZ.add(DataPoint<double>(value: stats.z, xAxis: step));
                    dataSum.add(DataPoint<double>(value: stats.sum, xAxis: step));
                    dataSpeed.add(DataPoint<double>(value: stats.speed, xAxis: step));
                    xAxisCustomValues.add(step);
                    step++;
                  });

                  return Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text('Data: ', style: TextStyles.body),
                            ),
                            Text('X-axis ', style: TextStyles.body.copyWith(color: Colors.redAccent)),
                            Text('Y-axis ', style: TextStyles.body.copyWith(color: Colors.greenAccent)),
                            Text('Z-axis ', style: TextStyles.body.copyWith(color: Colors.blueAccent)),
                          ],
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 80,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: BezierChart(
                              bezierChartScale: BezierChartScale.CUSTOM,
                              xAxisCustomValues: xAxisCustomValues,
                              series: [
                                BezierLine(lineColor: Colors.redAccent, data: dataX),
                                BezierLine(lineColor: Colors.greenAccent, data: dataY),
                                BezierLine(lineColor: Colors.blueAccent, data: dataZ),
                              ],
                              config: getChartConfig(10, context),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text('Data: ', style: TextStyles.body),
                            ),
                            Text('Sum of axes',
                                style: TextStyles.body.copyWith(color: AppColors.primaryColor)),
                          ],
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width - 80,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: BezierChart(
                              bezierChartScale: BezierChartScale.CUSTOM,
                              xAxisCustomValues: xAxisCustomValues,
                              series: [
                                BezierLine(lineColor: AppColors.primaryColor, data: dataSum),
                              ],
                              config: getChartConfig(30, context),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text('Data: ', style: TextStyles.body),
                            ),
                            Text('Speed',
                                style: TextStyles.body.copyWith(color: AppColors.secondaryColor)),
                          ],
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 80,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: BezierChart(
                              bezierChartScale: BezierChartScale.CUSTOM,
                              xAxisCustomValues: xAxisCustomValues,
                              series: [
                                BezierLine(lineColor: AppColors.secondaryColor, data: dataSpeed),
                              ],
                              config: getChartConfig(1, context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }),
        ],
      ),
    );
  }

  BezierChartConfig getChartConfig(stepsYAxis, BuildContext context) {
    return BezierChartConfig(
      yAxisTextStyle: TextStyle(color: AppColors.primaryColor),
      xAxisTextStyle: TextStyle(color: AppColors.primaryColor),
      stepsYAxis: stepsYAxis,
      displayYAxis: true,
      verticalIndicatorStrokeWidth: 3.0,
      verticalIndicatorColor: Colors.black26,
      showVerticalIndicator: true,
      backgroundColor: Colors.white,
      contentWidth: MediaQuery.of(context).size.width * 0.6,
      snap: false,
    );
  }
}
