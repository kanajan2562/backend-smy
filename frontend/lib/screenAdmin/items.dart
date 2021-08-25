import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websmy/utility/mystyle.dart';
import 'package:websmy/utility/normal_dialog.dart';

class Item extends StatefulWidget {
  Item({Key? key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late String code;
  late String nameItem;
  late double price;

  final _keyTxtCode = GlobalKey<FormState>();
  final _keyTxtName = GlobalKey<FormState>();
  final _keyTxtPrice = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: Container(
        color: Colors.white60,
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            codeForm(),
            nameForm(),
            priceForm(),
            comboCategory(),
            MyStly().mySizebox(),
            saveData(),
          ],
        ),
      ),
    );
  }

  Widget saveData() => Container(
        child: ElevatedButton.icon(
          onPressed: () {
            if (_keyTxtCode.currentState!.validate() &&
                _keyTxtName.currentState!.validate()) {
              print('$code');
            } else {
              normalDialog(context, 'กรุณาตรวจสอบข้อมูลให้ถูกต้อง ด้วยค่ะ!');
            }
          },
          icon: Icon(Icons.save),
          label: Text('Save'),
        ),
      );

  Widget codeForm() => Form(
        key: _keyTxtCode,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาตรวจสอบ Code';
            }
            return null;
          },
          onChanged: (value) => code = value.trim(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            filled: false,
            icon: Icon(
              Icons.check_circle,
              size: 32,
              color: Colors.redAccent[400],
            ),
            labelText: 'Code:',
            labelStyle: TextStyle(color: Colors.redAccent[400]),
          ),
        ),
      );
  Widget nameForm() => Form(
        key: _keyTxtName,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาตรวจสอบ Name Item';
            }
            return null;
          },
          onChanged: (value) => nameItem = value.trim(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            filled: false,
            icon: Icon(
              Icons.check_circle,
              size: 32,
              color: Colors.redAccent[400],
            ),
            labelText: 'Item Name:',
            labelStyle: TextStyle(color: Colors.redAccent[400]),
          ),
        ),
      );
  Widget priceForm() => Form(
        key: _keyTxtPrice,
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาตรวจสอบ Price';
            }
            return null;
          },
          onChanged: (value) => price,
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: false,
              icon: Icon(
                Icons.check_circle,
                size: 32,
                color: Colors.redAccent[400],
              ),
              labelText: 'Price',
              prefixText: '\฿ ',
              suffixText: 'Bath',
              suffixStyle: TextStyle(color: Colors.redAccent[400]),
              labelStyle: TextStyle(color: Colors.redAccent[400])),
        ),
      );
  late String valueCombo = 'Value1';
  Widget comboCategory() => Form(
        child: DropdownButton<String>(
          //Todo List builder.....
          value: valueCombo,
          onChanged: (String? newValue) {},
          items: <String>['Value1', 'Value2']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
      );
}
