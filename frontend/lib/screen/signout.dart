import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/screen/home.dart';

Future<Null> signOutProcess(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home());
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
