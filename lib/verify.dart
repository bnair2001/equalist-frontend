import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Color.fromARGB(255, 19, 19, 19),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: "Equa",
                style:
                    GoogleFonts.pressStart2p(fontSize: 40, color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: 'list',
                      style: GoogleFonts.pressStart2p(
                          fontSize: 40,
                          color: Color.fromARGB(215, 100, 215, 98))),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: _launchURL,
              child: Text("Login with Spotify"),
            ),
          ],
        ),
      ),
    );
  }
}
