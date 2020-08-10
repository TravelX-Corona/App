import 'package:flutter/material.dart';
import 'package:trip_planner/pages/mainpage.dart';
import 'package:trip_planner/pages/survey.dart';
import 'package:trip_planner/pages/login.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      highlightColor: Colors.black
    ),
    home: Login(),));
}