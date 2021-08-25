import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/constants.dart';
import 'package:websmy/screen/signin.dart';
import 'package:websmy/utility/my_constant.dart';
import 'package:websmy/utility/mystyle.dart';
import 'package:websmy/utility/normal_dialog.dart';

//import 'package:encrypt/encrypt.dart' as enc;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameformKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passFormKey = GlobalKey<FormState>();
  final _confirmPassFormKey = GlobalKey<FormState>();
  late String nameuser;
  late String email;
  late String inputEmail;
  late String type = "user";
  late String password;
  late String confirmPassword;
  late String countCheck;
  late String status;
  late String result;
  var encrypted;
  late String isAdd;

  ///Endcrypt
  TextEditingController tec = TextEditingController();

//  get borderSide => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
              child: Row(
            children: [cardImage(), cardFrom()],
          )),
        ),
      ),
      backgroundColor: kBgColor,
    );
  }

  Widget cardImage() => Container(
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.only(top: 0.0),
        child: Row(
          children: <Widget>[
            Card(
              color: Colors.blueGrey[900],
              child: SizedBox(
                width: 400,
                height: 400,
                child: MyStly().showLogoSignUp(),
              ),
            ),
          ],
        ),
      );
  Widget cardFrom() => Container(
        child: Row(
          children: <Widget>[
            Card(
              color: Colors.blueGrey[900],
              child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      MyStly().mySizebox(),
                      MyStly().mySizebox(),
                      showAppName(),
                      MyStly().mySizebox(),
                      nameFrom(),
                      MyStly().mySizebox(),
                      emailFrom(),
                      MyStly().mySizebox(),
                      passwordFrom(),
                      MyStly().mySizebox(),
                      confirmPasswordFrom(),
                      MyStly().mySizebox(),
                      MyStly().mySizebox(),
                      registerButton(),
                    ],
                  )),
            ),
          ],
        ),
      );

  Widget registerButton() => Container(
        width: 300,
        height: 35,
        child: ElevatedButton(
          onPressed: () {
            //validate form....key data
            if (_nameformKey.currentState!.validate() &&
                _emailFormKey.currentState!.validate() &&
                _passFormKey.currentState!.validate() &&
                _confirmPassFormKey.currentState!.validate() &&
                (password == confirmPassword)) {
              checkUser();
            } else {
              normalDialog(context, 'กรุณาตรวจสอบข้อมูลให้ถูกต้อง ด้วยค่ะ!');
            }
          },
          child: Text('Register', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );

  Future<Null> checkUser() async {
    var param = {
      "nameuser": nameuser,
      "email": inputEmail,
      "password": password,
      "type": type
    };
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/users/getUserWhereUser';
      Response<String> response = await dio.post(
        url,
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8"
          },
        ),
        data: jsonEncode(param), //Send data to BackEnd NodeJs
      );

      var result = jsonDecode(response.data.toString());
      countCheck = result['data'].toString();
      status = result['status'].toString();
      print(status);
      if (countCheck == "1") {
        normalDialog(context, "email นี้ถูกใช้ แล้วค่ะ");
      } else if (countCheck == "0") {
        String url = '${MyConstant().domain}/api/users/registerUser';
        Response<String> response = await dio.post(
          url,
          options: Options(
            responseType: ResponseType.json,
            method: "POST",
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
          ),
          data: jsonEncode(param),
        );
        var result = jsonDecode(response.data.toString());
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SignIn(),
        );
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(MyConstant().token, result["token"]); //set token register
        Navigator.push(context, route);

        print(result);
        print(result["token"]);
      }

      // var result = jsonDecode(response.data.toString()); //Decode Thai Mysql
      // //print('data===>$result');
      // for (var map in result) {
      //   // Get Data One User
      //   UserModel userModel = UserModel.fromJson(map);
      //   email = userModel.email;
      //   nameuser = userModel.nameuser;
      //   print('data=>$result');
      //   if (userModel != null) {
      //     print('object');
      //   } else {
      //     print('ooo');
      //   }
      // }
    } catch (e) {
      print(e);
    }
  }

  Text showAppName() {
    return Text('SIGN UP FROM @SAMAYA', style: TextStyle(fontSize: 22));
  }

  Widget nameFrom() => Form(
        key: _nameformKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 50,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาตรวจสอบ ชื่อ-นามสกุล';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                cursorColor: Colors.orange,
                style: TextStyle(color: Colors.orange),
                onChanged: (value) => nameuser = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    size: 24,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  hintText: 'Enter Your Name',
                  contentPadding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                  focusColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget emailFrom() => Form(
        key: _emailFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 50,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาตรวจสอบ อีเมลล์';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.orange,
                style: TextStyle(color: Colors.orange),
                onChanged: (value) => inputEmail = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  hintText: 'Enter Your Email Address',
                  contentPadding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                  focusColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget passwordFrom() => Form(
        key: _passFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 50,
              child: TextFormField(
                controller: tec,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'กรุณาตรวจสอบ Password';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Colors.orange,
                style: TextStyle(color: Colors.orange),
                onChanged: (value) {
                  password = value.trim();
                  setState(() {
                    password = tec.text;
                  });
                  print(password);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    size: 24,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  hintText: 'Enter Your Password',
                  contentPadding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                  focusColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget confirmPasswordFrom() => Form(
        key: _confirmPassFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 50,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'กรุณาตรวจสอบ ConfirmPassword';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Colors.orange,
                style: TextStyle(color: Colors.orange),
                onChanged: (value) => confirmPassword = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    size: 24,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  hintText: 'Enter Your ConfirmPassword',
                  contentPadding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                  focusColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
