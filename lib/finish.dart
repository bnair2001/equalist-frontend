import 'package:equalist/colors.dart';
import 'package:equalist/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FinishPage extends StatefulWidget {
  FinishPage({Key key, this.result}) : super(key: key);

  final Map result;
  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  //
  String imgUrl = "https://pixian.netlify.app/images/seed3875236.png";
  String playListName = "Loading Name...";
  String playListURL = "";
  //
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 4,
        color: EqualistColors.darkGreen,
      ),
    );
  }

  processData(var data) async {
    print("final mission");
    print(data);
    setState(() {
      imgUrl = data["playlist_cover"];
      playListName = data["playlist_name"];
      playListURL = data["playlist_url"];
    });
  }

  _launchURL() async {
    String url = playListURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget inTheBox() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(50.0),
      height: 500.0,
      decoration: myBoxDecoration(), //       <--- BoxDecoration here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: EqualistColors.darkGreen.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-3, 2), // changes position of shadow
                ),
              ],
            ),
            child: Image.network(
              imgUrl,
              width: 250,
              height: 250,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            playListName,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: EqualistColors.bannerFontSize,
              color: EqualistColors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: new Text(
              "Start Over",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: 12.0,
                color: EqualistColors.lightGreen,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ButtonTheme(
            minWidth: 110.0,
            height: 50.0,
            child: RaisedButton(
              color: EqualistColors.lightGreen,
              onPressed: () {
                _launchURL();
              },
              child: Text(
                "Play",
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

  @override
  Widget build(BuildContext context) {
    var data = widget.result;
    processData(data);
    return Scaffold(
      backgroundColor: EqualistColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: LinearProgressIndicator(
                    value: 1,
                    backgroundColor: EqualistColors.darkBackground,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        EqualistColors.lightGreen),
                  ),
                  height: 13.0,
                  //width: 20.0,
                )),
            SizedBox(
              height: 10,
            ),
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
              height: 10.0,
            ),
            inTheBox(),
          ],
        ),
      ),
    );
  }
}
