import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/qrcode/barcode_widget.dart';
import 'package:websmy/screen/signout.dart';
import 'package:websmy/screenAdmin/category.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:websmy/screenAdmin/items.dart';
import 'dart:async';

import 'package:websmy/utility/mystyle.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late String id;
  late String email;
  late String nameuser;
  late String chooseType;
  late String token;
  late String headerApi;
  ////SCAN QR//////
  late String _scanBarcode = 'Unknown';
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerTxtQrInput = TextEditingController();

  ///GENERATE QR//////
  late String _dataInputQr = '';
  late String valueCombo = 'Barcode';

  @override
  void initState() {
    super.initState();
    checkLogin();
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
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      final yourText = _scanBarcode;
      _controller.value = _controller.value.copyWith(
        text: _controller.text + yourText,
        selection: TextSelection.collapsed(
          offset: _controller.value.selection.baseOffset + yourText.length,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            action_1(),
          ],
          title: const Text('Administrator'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.data_saver_on),
                text: 'Menu1',
              ),
              Tab(
                icon: Icon(Icons.toggle_off_rounded),
                text: 'Menu2',
              ),
              Tab(
                icon: Icon(Icons.book),
                text: 'Menu3',
              ),
              Tab(
                icon: Icon(Icons.qr_code_2),
                text: 'QR-CR',
              ),
              Tab(
                icon: Icon(Icons.qr_code),
                text: 'QR-SC',
              )
            ],
          ),
        ),
        drawer: showDrawer(),
        body: TabBarView(
          children: <Widget>[
            P1(),
            P2(),
            P3(),
            P4(),
            P5(),
          ],
        ),
      ),
    );
  }

  Widget P1() {
    return Container(
      child: Center(
        child: Text("data1"),
      ),
    );
  }

  Widget P2() {
    return Container(
      color: Colors.orange,
      child: Center(
        child: Text("data2"),
      ),
    );
  }

  Widget P3() {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text("data3"),
      ),
    );
  }

  Widget P4() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            //   child: ElevatedButton(
            //     child: Text('SCAN QR CODE'),
            //     onPressed: () {
            //       ////Scan===>
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: <Widget>[
                  MyStly().mySizebox(),
                  comboSelect(),
                  MyStly().mySizebox(),
                  txtInputData(),
                  MyStly().mySizebox(),
                  buieldBarCode(valueCombo),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ElevatedButton(
                child: Text('QR CODE CAPTURE '),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comboSelect() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: DropdownButton<String>(
        value: valueCombo,
        icon: const Icon(Icons.check),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        iconEnabledColor: Colors.red,
        underline: Container(height: 2, color: Colors.blue),
        onChanged: (String? newValue) {
          setState(() {
            valueCombo = newValue!;
            if (valueCombo == "Barcode") {
              valueCombo == "Barcode";
            } else if (valueCombo == "QR-Code") {
              valueCombo == "QR-Code";
            }
          });
        },
        items: <String>['Barcode', 'QR-Code']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget txtInputData() {
    return TextFormField(
      controller: _controllerTxtQrInput,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.cancel_rounded,
              size: 32,
              color: Colors.amber,
            ),
            onPressed: () {
              setState(() {
                _dataInputQr = '';
              });
              _controllerTxtQrInput.clear();
            },
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _dataInputQr = value;
        });
        print(_dataInputQr);
      },
    );
  }

  Widget buieldBarCode(String seleted) {
    if (seleted == "Barcode") {
      return SingleChildScrollView(
        child: _dataInputQr.length > 0
            ? (Center(
                child: BarcodeWidget(
                  data: _dataInputQr,
                  barcode: Barcode.code128(),
                  width: 200,
                  height: 80,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ))
            : Center(
                child: Text('Please Input Value',
                    style: TextStyle(color: Colors.blue)),
              ),
      );
    } else if (seleted == "QR-Code") {}
    return SingleChildScrollView(
      child: _dataInputQr.length > 0
          ? (Center(
              child: BarcodeWidget(
                data: _dataInputQr,
                barcode: Barcode.qrCode(),
                width: 200,
                height: 80,
              ),
            ))
          : Center(
              child: Text('Please Input Value',
                  style: TextStyle(color: Colors.blue)),
            ),
    );
  }

  Widget P5() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(60, 0, 15, 0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.qr_code),
                label: Text('SCAN QR CODE.'),
                onPressed: () {
                  _controller.clear();
                  scanQR();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) =>QRCode() ));
                  // Navigator.of(context).push(
                  //     new MaterialPageRoute(builder: (BuildContext context) {
                  //   return new AdminHome();
                  // }));
                },
              ),
            ),

            SizedBox(
              height: 15,
            ),
            // Container(
            //   child: Text(
            //     _scanBarcode.isEmpty ? "Process!" : _scanBarcode,
            //     style: TextStyle(fontSize: 20, color: Colors.black),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: _controller,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel_rounded,
                      size: 32,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: [
          showHead(),
          categoryMenu(),
          item(),
          signOut(),
        ],
      ),
    );
  }

  Widget action_1() {
    return IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Well Come To...")));
        },
        icon: Icon(Icons.add_business));
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      accountName: Text('User : ${nameuser}'),
      accountEmail: Text('Email : ${email}'),
    );
  }

  Widget categoryMenu() {
    return ListTile(
      leading: Icon(Icons.group_add),
      title: Text(
        'ตั้งค่า-หมวดหมู่',
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w900),
      ),
      onTap: () {
        // No Back===>
        // MaterialPageRoute route =
        //     MaterialPageRoute(builder: (context) => Category());
        //  Navigator.pushAndRemoveUntil(context, route, (route) => true);
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => Category());
        Navigator.push(context, route);
      },
    );
  }

  Widget item() {
    return ListTile(
      leading: Icon(Icons.engineering),
      title: Text(
        'ทรัพสินย์',
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w900),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => Item());
        Navigator.push(context, route);
      },
    );
  }

  Widget signOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app_outlined,
        color: Colors.red,
      ),
      title: Text(
        'ออกจากระบบ',
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w900),
      ),
      subtitle: Text('กลับไปหน้าแรก'),
      onTap: () {
        setState(() {
          signOutProcess(context);
        });
      },
    );
  }
}
