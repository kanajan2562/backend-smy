import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/model/category_model.dart';
import 'package:websmy/screen/signin.dart';
import 'package:websmy/utility/my_constant.dart';


class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String id;
  late String email;
  late String nameuser;
  late String chooseType;
  late String token;
  late String headerApi;

  /////////////

  late List<CategoryModels> _result = [];
  late String categoryName;

  bool toggle = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
    getCategory();
  }

  Future<Null> checkLogin() async {
    var fNull = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token').toString() != fNull) {
      setState(() {
        id = sharedPreferences.getString('id').toString();
        nameuser = sharedPreferences.getString('nameuser').toString();
        email = sharedPreferences.getString('email').toString();
        token = sharedPreferences.getString('token').toString();
      });
    } else {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => SignIn());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            
            columns: [
              DataColumn(label: Text('id')),
              DataColumn(label: Text('categoryname')),
              DataColumn(label: Text('Delete'))
            ],
            rows: _result
                .map(
                  (value) => DataRow(cells: [
                    DataCell(
                      Text(value.id.toString()),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(
                        value.categoryname.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        print(value.id);
                      },
                    ))
                  ]),
                )
                .toList(),
                
          ),
        ),
      ),
    );
  }

  Future<List<CategoryModels>> getCategory() async {
    String path = '${MyConstant().domain}/api/category/all';
    Response<String> response = await Dio().get(path);
    var value = jsonDecode(response.data.toString());
    for (var item in value) {
      setState(() {
        CategoryModels models = CategoryModels.fromJson(item);
        _result.add(models);
      });
    }
    return _result;
  }
}
