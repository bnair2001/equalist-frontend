import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Verify extends StatefulWidget {
  Verify({Key key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    bool login = await Services.checkLogin();
    print(login);
  }

  _launchURL() async {
    const url = 'https://calm-oasis-20606.herokuapp.com/login';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 28, 26, 26),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Equalist"),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: _launchURL,
              child: Text("Login to Spotify"),
            ),
          ],
        ),
      ),
    );
  }
}
