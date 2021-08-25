import 'package:flutter/material.dart';
import 'package:websmy/components/slideImage.dart';
import 'package:websmy/screen/signin.dart';
import 'package:websmy/screen/signup.dart';
import 'package:websmy/utility/mystyle.dart';

class Home extends StatefulWidget {
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMY'),
      ),
      drawer: showDrawer(),
      body: Column(
        children: [SlideImages(), Text('อยู่ระหว่างการจัดทำ')],
      ),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[showHeaDrawer(), signInMenu(), signUpMenu()],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(
        Icons.verified_user,
        color: Colors.green,
      ),
      title: Text(
        'Sign In',
        style:
            TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w900),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      subtitle: Text(
        'Register to remember',
        textAlign: TextAlign.justify,
      ),
      leading: Icon(
        Icons.people,
        color: Colors.amber[900],
      ),
      title: Text(
        'Sign Up',
        style: TextStyle(color: Colors.brown[900], fontWeight: FontWeight.w900),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Signup());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeaDrawer() {
    return UserAccountsDrawerHeader(
      currentAccountPictureSize: Size(72, 72),
      currentAccountPicture: MyStly().showLogo(),
      accountName: Text('Guest'),
      accountEmail: Text('Please Login'),
    );
  }
}
