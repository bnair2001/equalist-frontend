import 'package:equalist/colors.dart';
import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        border: Border.all(
          width: 4,
          color: EqualistColors.darkGreen,
        ),
      );
    }

    Widget inTheBox() {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 12),
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 500.0,
        decoration: myBoxDecoration(), //       <--- BoxDecoration here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Create",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: EqualistColors.bannerFontSize,
                //fontSize: 30,
                color: EqualistColors.lightGreen,
              ),
            ),
            SizedBox(
              height: EqualistColors.heightBtwBannerWords,
            ),
            Text(
              "Collaborative",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: EqualistColors.bannerFontSize,
                color: EqualistColors.lightGreen,
              ),
            ),
            SizedBox(
              height: EqualistColors.heightBtwBannerWords,
            ),
            Text(
              "playlists",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: EqualistColors.bannerFontSize,
                color: EqualistColors.lightGreen,
              ),
            ),
            SizedBox(
              height: EqualistColors.heightBtwBannerWords,
            ),
            Text(
              "instantly",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: EqualistColors.bannerFontSize,
                color: EqualistColors.lightGreen,
              ),
            ),
            SizedBox(
              height: 180,
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 120.0,
              child: RaisedButton(
                color: EqualistColors.lightGreen,
                onPressed: _launchURL,
                child: Text(
                  "Login with Spotify",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    //fontSize: EqualistColors.bannerFontSize,
                    fontSize: 20,
                    color: EqualistColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: EqualistColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: "Equa",
                style: GoogleFonts.pressStart2p(
                    fontSize: 35, color: EqualistColors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: 'list',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 35,
                        color: EqualistColors.lightGreen,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            inTheBox(),
          ],
        ),
      ),
    );
  }
}
