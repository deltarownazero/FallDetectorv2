import 'package:bezier_chart/bezier_chart.dart';
import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartWidget extends StatelessWidget {
  final List<DataPoint> data, fallData;
  final String labelName;

  const ChartWidget({Key key, this.data, this.labelName, this.fallData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        AppConstants.labels,
                        style: TextStyles.body,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(AppConstants.fallsLabel,
                          style: TextStyles.body.copyWith(color: AppColors.primaryColor)),
                    ),
                    Text(labelName, style: TextStyles.body.copyWith(color: AppColors.secondaryColor)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<LabelProvider>().deleteLabelFromChartList(labelName);
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
          Center(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: BezierChart(
                  bezierChartScale: BezierChartScale.CUSTOM,
                  xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                  series: [
                    BezierLine(lineColor: AppColors.secondaryColor, data: data),
                    BezierLine(lineColor: AppColors.primaryColor, data: fallData),
                  ],
                  config: BezierChartConfig(
                    yAxisTextStyle: TextStyle(color: AppColors.primaryColor),
                    xAxisTextStyle: TextStyle(color: AppColors.primaryColor),
                    stepsYAxis: 100,
                    displayYAxis: true,
                    verticalIndicatorStrokeWidth: 3.0,
                    verticalIndicatorColor: Colors.black26,
                    showVerticalIndicator: true,
                    backgroundColor: Colors.white,
                    contentWidth: MediaQuery.of(context).size.width * 0.6,
                    snap: false,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
