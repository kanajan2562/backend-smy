import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:websmy/constants.dart';
import 'package:websmy/utility/my_constant.dart';
import 'package:websmy/utility/mystyle.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}



class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  late String nameuser;
  late String email;
  late String password;
  late String confirmPassword;

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
              child: new Form(
                  key: _formKey,
                  child: Row(
                    children: [cardImage(), cardFrom()],
                  ))),
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
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('true');
            } else {
              print('false');
            }

            checkUser();

            ///check user
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );

  Future<Null> checkUser() async {
    // FormData fromData = new FormData.fromMap({'email': email});
    try {
      Dio dio = new Dio();
      // dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
      // dio.options.headers['Access-Control-Allow-Origin'] = '*';
      // dio.options.headers['Access-Control-Allow-Methods'] = 'GET , POST';

      String url = '${MyConstant().domain}/api/users/getUserWhereUser';
      Response response = await dio.post(url, data: {'email': email});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Text showAppName() {
    return Text('SIGN UP FROM @SAMAYA', style: TextStyle(fontSize: 22));
  }

  Widget nameFrom() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300.0,
            height: 40,
            child: TextFormField(
              key: _formKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาตรวจสอบ ชื่อ-นามสกุล';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              cursorColor: Colors.orange,
              style: TextStyle(color: Colors.orange),
              onChanged: (value) => nameuser = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  labelText: 'Name:',
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().primaryColor))),
            ),
          ),
        ],
      );

  Widget emailFrom() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300.0,
            height: 40,
            child: TextFormField(
             // key: _formKey,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.orange,
              style: TextStyle(color: Colors.orange),
              onChanged: (value) => email = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  labelText: 'Email:',
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().primaryColor))),
            ),
          ),
        ],
      );

  Widget passwordFrom() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300.0,
            height: 40,
            child: TextFormField(
            //  key: _formKey,
              keyboardType: TextInputType.text,
              cursorColor: Colors.orange,
              style: TextStyle(color: Colors.orange),
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  labelText: 'Password:',
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().primaryColor))),
            ),
          ),
        ],
      );

  Widget confirmPasswordFrom() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300.0,
            height: 40,
            child: TextFormField(
              //key: _formKey,
              keyboardType: TextInputType.text,
              cursorColor: Colors.orange,
              style: TextStyle(color: Colors.orange),
              onChanged: (value) => confirmPassword = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: MyStly().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStly().darkColor),
                  labelText: 'Confirm Password:',
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStly().primaryColor))),
            ),
          ),
        ],
      );
}
