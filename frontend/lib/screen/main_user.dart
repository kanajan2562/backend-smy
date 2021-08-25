import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websmy/screen/signout.dart';

class MainUser extends StatefulWidget {
  const MainUser({Key? key}) : super(key: key);
  

  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  late String id;
  late String email;
  late String nameuser;
  late String chooseType;
  late String token;
  late String headerApi;

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
        headerApi = sharedPreferences.get('headerApi').toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main User '),
      ),
      body: Center(
        child: Text(headerApi.toString()),
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHead(),
            meun1(),
            meun2(),
            meun3(),
            meun4(),
            meun5(),
            signOut()
          ],
        ),
      );
  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        accountName: Text('$nameuser'), accountEmail: Text('$email'));
  }

  ListTile meun1() => ListTile(
        leading: Icon(Icons.engineering),
        title: Text(
          'ทรัพย์สิน',
          style:
              TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
        ),
        subtitle: Text('รายการทั้งหมด'),
        onTap: () {
          setState(() {});
          Navigator.pop(context);
        },
      );
  ListTile meun2() => ListTile(
        leading: Icon(Icons.engineering),
        title: Text(
          'บันทึก-ทรัพย์สิน',
          style:
              TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
        ),
        subtitle: Text('รายการทั้งหมด'),
        onTap: () {
          setState(() {});
          Navigator.pop(context);
        },
      );
  ListTile meun3() => ListTile(
        leading: Icon(Icons.engineering),
        title: Text(
          'ปรับปรุง-ทรัพย์สิน',
          style:
              TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
        ),
        subtitle: Text('รายการทั้งหมด'),
        onTap: () {
          setState(() {});
          Navigator.pop(context);
        },
      );
  ListTile meun4() => ListTile(
        leading: Icon(Icons.engineering),
        title: Text(
          'ทรัพย์สิน',
          style:
              TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
        ),
        subtitle: Text('รายการทั้งหมด'),
        onTap: () {
          setState(() {});
          Navigator.pop(context);
        },
      );
  ListTile meun5() => ListTile(
        leading: Icon(Icons.engineering),
        title: Text(
          'ทรัพย์สิน',
          style:
              TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
        ),
        subtitle: Text('รายการทั้งหมด'),
        onTap: () {
          setState(() {});
          Navigator.pop(context);
        },
      );
  ListTile signOut() => ListTile(
        leading: Icon(Icons.exit_to_app_outlined),
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
