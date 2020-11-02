import 'dart:async';
import 'package:fall_detector/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'gps_details.dart';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Position _userLocation;
  Position _lastLocation;
  double _distanceInMeters = 0;
  double _speed;
  int _counter = AppConstants.distanceVerificationTime;

  @override
  void initState() {
    getPermissions();
    localize();
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GpsDetails(
            title: AppConstants.location,
            value: _userLocation == null
                ? AppConstants.unknown
                : '${_userLocation.latitude.toStringAsFixed(5)}, ${_userLocation.longitude.toStringAsFixed(5)}'),
        GpsDetails(
            title: AppConstants.speed,
            value: _speed == null ? AppConstants.unknown : '${_speed.toStringAsFixed(2)} m/s'),
        GpsDetails(
            title: AppConstants.distance,
            value: _distanceInMeters == null
                ? AppConstants.unknown
                : '${_distanceInMeters.toStringAsFixed(2)} m'),
      ],
    );
  }

  void localize() {
    try {
      Geolocator.getPositionStream().listen((Position position) {
        setState(() {
          _lastLocation = _userLocation;
          _userLocation = position;
        });
        calculateDistance();
      });
    } catch (e) {}
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
      } else {
        setState(() {
          calculateSpeed();
          _distanceInMeters = 0;
        });
        _counter = AppConstants.distanceVerificationTime;
      }
    });
  }

  void getPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
  }

  void calculateDistance() {
    if (_userLocation != null && _lastLocation != null) {
      setState(() {
        _distanceInMeters = _distanceInMeters +
            Geolocator.distanceBetween(_userLocation.latitude, _userLocation.longitude,
                _lastLocation.latitude, _lastLocation.longitude);
      });
    }
  }

  void calculateSpeed() {
    if (_distanceInMeters != null) {
      setState(() {
        _speed = _distanceInMeters / AppConstants.distanceVerificationTime;
      });
    }
  }
}
