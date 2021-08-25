import 'package:flutter/material.dart';

class MyStly {
  
  Color darkColor = Colors.white;
  Color primaryColor = Colors.white;

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/$namePic'), fit: BoxFit.cover));
  }

  Container showLogo() {
    return Container(
      child: Image.asset('assets/images/useraccount.png'),
    );
  }
  Card showLogoSignUp() {
    return Card(
      child: Image.asset('assets/images/signup.jpg',width: 400,height: 400,),
    );
  }

  MyStly();
}
