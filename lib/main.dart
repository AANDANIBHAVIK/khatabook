import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/screen/homeScreen.dart';


void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (context) => Home_Screen(),
      //   '/add': (context) => Add_Screen(),
      //   '/customer': (context) => Customer_Screen(),
      //   '/gave': (context) => Gave_Payment(),
      //   '/got': (context) => Got_Payment(),
      // },
      home: Home_Screen(),
    ),
  );
}
