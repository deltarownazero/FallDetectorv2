import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:fall_detector/providers/stats_provider.dart';
import 'package:fall_detector/services/local_database.dart';
import 'package:fall_detector/widgets/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fall_detector/providers/label_provider.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/widgets/acc_details.dart';
import 'package:fall_detector/widgets/app_logo.dart';
import 'package:fall_detector/screens/settings_screen.dart';
import 'package:fall_detector/widgets/primary_button.dart';
import 'package:fall_detector/widgets/time_widget.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.nameApp,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ChangeNotifierProvider<StatsProvider>(
          create: (_) => StatsProvider(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: AppLogo(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppConstants.actualLabel,
                                style: TextStyles.headingMedium,
                              ),
                              Text(
                                context.watch<LabelProvider>().actualLabel,
                                style: TextStyles.headingMedium.copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 16,
                            child: BouncingWidget(
                              duration: Duration(milliseconds: 100),
                              scaleFactor: -1.5,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                                );
                              },
                              child: Icon(
                                Icons.settings_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    LocationWidget(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  TimeWidget(),
                  PrimaryButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text('Warning'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Are you sure you want to report a fall?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Report'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  LocalDatabase().setFallLabels(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: AppConstants.reportFall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 4),
                    child: AccDetails(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
