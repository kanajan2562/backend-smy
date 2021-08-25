import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/model/user_model.dart';
import 'package:websmy/screen/main_user.dart';
import 'package:websmy/screenAdmin/adminHome.dart';

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
  //Field
  late String email ='admin@gmail.com';
  late String password='1111';
  late String chooseType;
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
            HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            HttpHeaders.authorizationHeader:"Bearers",
          },
        ),
        data: jsonEncode(param),
      );
      print(response.statusCode.toString());
      
      var result = jsonDecode(response.toString());
      for (var map in result) {
        UserModel userModel = await UserModel.fromJson(map);
        email = userModel.email;
        password = userModel.password;
        chooseType = userModel.type;
        token = userModel.token;

        if (userModel.password == password && response.statusCode == 200) {
          if (chooseType == 'user') {
            routeToService(MainUser(), userModel);
          } else if (chooseType == 'admin') {
            routeToService(AdminHome(), userModel);
          } else {
            normalDialog(context, 'Error :กรุณาลองใหม่');
          }
        } else {
          normalDialog(context, "รหัสผ่านไม่ถูกต้องค่ะ! กรุณาลองใหม่ ");
        }
      }
    } catch (e) {
     // normalDialog(context, "Email หรือ Password ไม่ถูกต้องค่ะ! กรุณาลองใหม่ ");
      print(e);
    }
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        MyConstant().keyId.toString(), userModel.id.toString());
    sharedPreferences.setString(MyConstant().keyType, userModel.type);
    sharedPreferences.setString(MyConstant().keyName, userModel.nameuser);
    sharedPreferences.setString(MyConstant().email, userModel.email);
    sharedPreferences.setString(MyConstant().token, userModel.token);
    sharedPreferences.setString(
        MyConstant().headerApi, userModel.token);

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
