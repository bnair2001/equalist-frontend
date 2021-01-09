import 'package:equalist/colors.dart';
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
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(70.0),
        decoration: myBoxDecoration(), //       <--- BoxDecoration here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Create",
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
              height: 20,
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                color: EqualistColors.lightGreen,
                onPressed: _launchURL,
                child: Text(
                  "Login with Spotify",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    fontSize: EqualistColors.bannerFontSize,
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
              height: 120,
            ),
            inTheBox(),
          ],
        ),
      ),
    );
  }
}
