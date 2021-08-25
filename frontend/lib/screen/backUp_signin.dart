import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/model/user_model.dart';

import 'dart:async';
import 'package:websmy/utility/my_constant.dart';
import 'package:websmy/utility/mystyle.dart';
import 'package:websmy/utility/normal_dialog.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String chooseType;
  //Field
  late String email = "u27@gmail.com";

  late String password = "1111";
  late String token;

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStly().darkColor,
            ),
            labelStyle: TextStyle(color: MyStly().darkColor),
            labelText: 'Email :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStly().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStly().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStly().darkColor,
            ),
            labelStyle: TextStyle(color: MyStly().darkColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStly().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStly().primaryColor)),
          ),
        ),
      );

  Widget loginButton() => Container(
        width: 250.0,
        child: ElevatedButton(
          onPressed: () {
            var e, p = null;
            if (email == e ||
                email.isEmpty ||
                password == p ||
                password.isEmpty) {
              normalDialog(context, 'กรุณากรอกให้ครบ คะ!');
            } else {
              ///Todo
              checkAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    var param = {"email": email, "password": password};
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/users/signin';
      Response<String> response = await dio.post(
        url,
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8", //
          },
        ),
        data: jsonEncode(param),
      );
      
      var result = jsonDecode(response.toString()); //e
      token = result[0]["token"];
      print(result);
      //print(token);

      for (var map in result) {
        UserModel userModel = await UserModel.fromJson(map);
        email = userModel.email;
        print(email);
      }

      //for (var map in result) {
      // UserModel userModel = UserModel.fromJson(map);
      // email = userModel.email;
      // password = userModel.password;
      // chooseType = userModel.type;
      // token = userModel.token;
      // print(chooseType);

      //   // if (userModel.password == password && response.statusCode == 200) {
      //   //   print(chooseType);
      //   //   // if (chooseType == "user") {
      //   //   //   routeToService(MainUser(), userModel, token);
      //   //   // }
      //   //   //Todo ....
      //   // } else {
      //   //   normalDialog(context, "รหัสผ่านไม่ถูกต้องค่ะ! กรุณาลองใหม่ ");
      //   // }
      //}
    } catch (e) {
      print(e);
    }
  }

  Future<Null> routeToService(
      Widget myWidget, UserModel userModel, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        MyConstant().keyId.toString(), userModel.id.toString());
    sharedPreferences.setString(MyConstant().keyType, userModel.type);
    sharedPreferences.setString(MyConstant().keyName, userModel.nameuser);
    sharedPreferences.setString(MyConstant().token, userModel.token);

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStly().mySizebox(),
                userForm(),
                MyStly().mySizebox(),
                passwordForm(),
                MyStly().mySizebox(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
