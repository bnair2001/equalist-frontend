import 'dart:convert';

import 'package:equalist/colors.dart';
import 'package:equalist/fluro_router.dart';
import 'package:equalist/options.dart';
import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clippy/browser.dart' as clippy;

class WaitingRoom extends StatefulWidget {
  WaitingRoom({Key key}) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  String url = "Loading link ....";
  int count = 0;
  var people = [];
  String sess_id = "";
  String url_key = "";
  SharedPreferences prefs;
  getUrlAndHomies() async {
    prefs = await Services.sharedprefs();
    setState(() {
      sess_id = prefs.getString("session_id");
      url_key = prefs.getString("url_key");
      url = "https://equalist.tech/homie?key=" + url_key;
    });
    //get the homies
    var response = await http.get(Services.apiUrl + "get-homies/" + sess_id);
    Map valueMap = json.decode(response.body);
    print(valueMap);
    setState(() {
      if (valueMap["homies"] != null) {
        people = valueMap["homies"];
      } else {
        people = [
          {"name": "No Homies yet"}
        ];
      }
    });
  }

  @override
  void initState() {
    count = 0;
    getUrlAndHomies();
    super.initState();
  }

  startButton(BuildContext context) {
    Services.makeSound(true);
    FRouter.router.navigateTo(context, "/options");
  }

  refreshList() async {
    Services.makeSound(false);
    //get the homies
    var response = await http.get(Services.apiUrl + "get-homies/" + sess_id);
    Map valueMap = json.decode(response.body);
    print(valueMap);
    setState(() {
      people = valueMap["homies"];
    });
  }

  copyUrl() async {
    Services.makeSound(false);
    await clippy.write(url);
  }

  @override
  Widget build(BuildContext context) {
    //
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        border: Border.all(
          width: 4,
          color: EqualistColors.darkGreen,
        ),
      );
    }

    Widget copyLink() {
      return Container(
          margin: const EdgeInsets.all(30.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: EqualistColors.lightGreen, width: 4),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                url,
                style: GoogleFonts.quicksand(
                  color: EqualistColors.white,
                ),
              ),
              Text('        '),
              IconButton(
                icon: Icon(
                  Icons.copy,
                  color: EqualistColors.lightGreen,
                ),
                onPressed: copyUrl,
                enableFeedback: true,
              ),
            ],
          ));
    }

    Widget _myListView(BuildContext context) {
      return Container(
          //margin: const EdgeInsets.all(20.0),
          //padding: const EdgeInsets.all(5.0),
          height: 120.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: EqualistColors.lightGreen,
            ),
          ), //       <--- BoxDecoration here
          child: ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                title: Text(
                  people[index]["name"],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 15.0,
                    color: EqualistColors.white,
                  ),
                ),
              );
            },
          ));
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
            Text(
              "Invite your homies",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                color: EqualistColors.white,
              ),
            ),
            // SizedBox(
            //   height: 2.0,
            // ),
            copyLink(),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Your guild so far",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    color: EqualistColors.white,
                  ),
                ),
                Text('    '),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: EqualistColors.lightGreen,
                  ),
                  enableFeedback: true,
                  onPressed: refreshList,
                ),
              ],
            ),
            _myListView(context),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 150.0,
              height: 50.0,
              child: RaisedButton(
                color: EqualistColors.lightGreen,
                onPressed: () {
                  startButton(context);
                },
                child: Text(
                  "Press to Start",
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: LinearProgressIndicator(
                    value: 0.3,
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
              height: 40,
            ),
            inTheBox(),
          ],
        ),
      ),
    );
  }
}
