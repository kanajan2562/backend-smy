import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/model/category_model.dart';
import 'package:websmy/screen/signin.dart';
import 'package:websmy/utility/my_constant.dart';
import 'package:websmy/utility/mystyle.dart';
import 'package:websmy/utility/normal_dialog.dart';

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
  late BuildContext context;
  late String searchValue = '';

  /////////////
  late String categoryName;
  /////DesignModel readData
  List<CategoryModels> categoryModels = [];
  List<String> list_id = [];
  List<String> list_categoryname = [];
  List<CategoryModels> _result = [];
  final _categoryNameController = TextEditingController();

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

  Future _FunctionDeleteByID(int id) async {
    var param = {"id": id};
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/category/delete:id';
      Response<String> response = await dio.delete(
        url,
        options: Options(method: "DELETE", headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearers",
        }),
        data: jsonEncode(param),
      );
      var result = jsonDecode(response.data.toString());
      print(result);
      setState(() {
        getCategory();
      });
      print(_result.length);
    } catch (e) {
      print(e);
    }
  }

  Future _FucntionEditByID(int id, String categoryName) async {
    var param = ({"id": id, "categoryName": categoryName});
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/category/edit:id';
      Response<String> response = await dio.put(
        url,
        options: Options(method: "PUT", headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearers",
        }),
        data: jsonEncode(param),
      );
      var result = jsonDecode(response.data.toString());
      print(result);
      setState(() {
        getCategory();
      });
    } catch (e) {
      print(e);
    }
  }

  Future _FunctionSearch(String categoryName) async {
    _result.clear();
    var param = ({"categoryName": categoryName});
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/category/search';
      Response<String> response = await dio.post(
        url,
        options: Options(method: "PUT", headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearers",
        }),
        data: jsonEncode(param),
      );
      var result = jsonDecode(response.data.toString());
      for (var item in result) {
        CategoryModels models = CategoryModels.fromJson(item);
        setState(() {
          _result.add(models);
        });
      }
      return _result;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    MySource mySource =
        new MySource(_result, context, _FunctionDeleteByID, _FucntionEditByID);
    return Scaffold(
        appBar: AppBar(
          title: Text('Back'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ContainerHead(),
              //Widget form
              PaginatedDataTable(
                columnSpacing: 56,
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        getCategory();
                      });
                    },
                    icon: Icon(Icons.refresh_outlined),
                    color: Colors.black,
                  ),
                  IconButton(
                      onPressed: () {
                        searchValue = '';
                        print('Search');
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext) {
                              return AlertDialog(
                                backgroundColor: Colors.amber,
                                title: Text('Search'),
                                content: new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      child: new TextField(
                                        autofocus: true,
                                        decoration: new InputDecoration(
                                          labelText: 'Search ?',
                                        ),
                                        onChanged: (value) {
                                          /////Fucntion search
                                          searchValue = value;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  ElevatedButton.icon(
                                    label: Text('SEARCH'),
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      Navigator.of(context).pop(searchValue);
                                      if (searchValue.isEmpty) {
                                        print('null');
                                      } else {
                                        print(searchValue);
                                        _FunctionSearch(searchValue);
                                      }
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.pink,
                      )),
                ],
                header: Center(child: Text('List Details.')),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('ID', style: TextStyle(color: Colors.black)),
                  ),
                  DataColumn(
                    label: Text(
                      'Category Name',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text('[ Edit ]',
                        style: TextStyle(color: Colors.red[600])),
                  ),
                  DataColumn(
                    label: Text('[ Delete ]',
                        style: TextStyle(color: Colors.red[600])),
                  ),
                ],
                source: mySource,
                rowsPerPage: 10,
              ),
            ],
          ),
        ));
  }

  Future<List<CategoryModels>> getCategory() async {
    _result.clear();
    String path = '${MyConstant().domain}/api/category/all';
    Response<String> response = await Dio().get(path);
    var value = jsonDecode(response.data.toString());
    for (var item in value) {
      CategoryModels models = CategoryModels.fromJson(item);
      setState(() {
        _result.add(models);
      });
    }
    print(_result.length);
    return _result;
  }

  Widget ContainerHead() => Container(
        margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
        width: double.infinity,
        height: 80,
        child: Card(
          color: Colors.amber,
          child: Row(
            children: <Widget>[CategoryForm(), saveButton()],
          ),
        ),
      );
  Widget ContainerData() => Container(
        color: Colors.brown[100],
        child: Row(
          children: <Widget>[
            Text('data1'),
            Text('data2'),
            Text('data3'),
          ],
        ),
      );
  Widget CategoryForm() => Container(
        width: 280,
        height: 40,
        margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
        child: TextField(
          
          controller: _categoryNameController, //controller
          onChanged: (value) => categoryName = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.document_scanner_rounded,
                  color: MyStly().darkColor),
              labelText: 'ชื่อหมวดหมู่',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStly().darkColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStly().primaryColor))),
        ),
      );
  Widget saveButton() => Container(
        width: 80.0,
        height: 40,
        margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            var e = null;
            if (categoryName == e || categoryName.isEmpty) {
              normalDialog(context, 'กรุณากรอกให้ครบ คะ!');
            } else {
              Insert(categoryName);
            }
            setState(() {
              _categoryNameController.clear();
            });
          },
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
////////////
  Future Insert(String categoryName) async {
    var param = {"categoryName": categoryName};
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/category/insert';
      Response<String> response = await dio.post(
        url,
        options: Options(method: "POST", headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearers",
        }),
        data: jsonEncode(param),
      );
      var result = jsonDecode(response.data.toString());
      setState(() {
        getCategory();
      });
      print(result.toString());
    } catch (e) {
      print(e);
    }
  }

  Future Delete(int id) async {
    var param = {"id": id};
    try {
      Dio dio = new Dio();
      String url = '${MyConstant().domain}/api/category/delete:id';
      Response<int> response = await dio.delete(
        url,
        options: Options(method: "DELETE", headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearers",
        }),
        data: jsonEncode(param),
      );
      var result = jsonDecode(response.data.toString());
      setState(() {
        getCategory();
      });

      print(result);
    } catch (e) {
      print(e);
    }
  }
}

class MySource extends DataTableSource {
  final List<CategoryModels> value;
  final BuildContext context;
  final Function(int) _deleteData;
  final Function(int, String) _editData;
  MySource(this.value, this.context, this._deleteData, this._editData);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(value[index].id.toString(),
            style: TextStyle(color: Colors.blue))),
        DataCell(Text(value[index].categoryname,
            style: TextStyle(color: Colors.blue))),
        DataCell(
          SizedBox(
            width: 75,
            height: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                String _valueCategoryName = '';
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Edit Category Name'),
                      content: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'ชื่อ หมวดหมู่',
                                  hintText:
                                      value[index].categoryname.toString()),
                              onChanged: (value) {
                                _valueCategoryName = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton.icon(
                          label: Text('Ok'),
                          icon: Icon(Icons.check),
                          onPressed: () {
                            Navigator.of(context).pop(_valueCategoryName);
                            if (_valueCategoryName.isEmpty) {
                              print('null');
                            } else {
                              print(_valueCategoryName);
                              _editData(value[index].id, _valueCategoryName);
                            }
                          },
                        ),
                        ElevatedButton.icon(
                          label: Text('Cancle'),
                          icon: Icon(Icons.cancel_outlined),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.edit,
                size: 16,
              ),
              label: Text(
                'edit',
                style: TextStyle(fontSize: 12, color: Colors.amber),
              ),
            ),
          ),
        ),
        DataCell(SizedBox(
          child: IconButton(
              onPressed: () {
                print('Delete');
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Delete ?',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Text(
                          'Are You Sure Delete ${value[index].categoryname}'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('YES'),
                          onPressed: () {
                            _deleteData(value[index].id);
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.pink,
              )),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => value.length;
  @override
  int get selectedRowCount => 0;
//////////////////////////////////////////////////Controller

}
