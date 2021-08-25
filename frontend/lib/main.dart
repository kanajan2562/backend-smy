import 'package:flutter/material.dart';
import 'package:websmy/constants.dart';
import 'package:websmy/screen/home.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '@SAMAYABURA Demo',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBgColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
            bodyText2: TextStyle(color: kBodyTextColor),
            headline5: TextStyle(color: kDarkBlackColor),
          )),
      home: Home(),
      
    );
  }
}
