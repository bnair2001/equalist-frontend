import 'dart:convert';
import 'dart:html';

import 'package:equalist/colors.dart';
import 'package:equalist/finish.dart';
import 'package:equalist/loading.dart';
import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsPage extends StatefulWidget {
  OptionsPage({Key key}) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  Map<String, bool> values = {
    'recommendation': false,
    'asynchronous invite': true,
    // '"Fair and Square"': false,
    'share it to all': false,
    'disable playlist sequencing': false
  };

  int finalsize = 0;
  //
  //
  Color threeColorSmall = Colors.white;
  Color threeColorMedium = Colors.white;
  Color threeColorChungus = Colors.white;
  //
  TextDecoration threeDecSmall = TextDecoration.none;
  TextDecoration threeDecMedium = TextDecoration.none;
  TextDecoration threeDecChungus = TextDecoration.none;
  //
  //
  TextStyle threeSizes(int siz) {
    Color threeColor;
    TextDecoration threeDec;
    if (siz == 1) {
      threeColor = threeColorSmall;
      threeDec = threeDecSmall;
    } else if (siz == 2) {
      threeColor = threeColorMedium;
      threeDec = threeDecMedium;
    } else {
      threeColor = threeColorChungus;
      threeDec = threeDecChungus;
    }
    TextStyle textStyle = GoogleFonts.quicksand(
      color: threeColor,
      decoration: threeDec,
    );
    return textStyle;
  }

  void resetThreeSizes() {
    setState(() {
      print("hi");
      threeColorSmall = Colors.white;
      threeColorMedium = Colors.white;
      threeColorChungus = Colors.white;
      //
      threeDecSmall = TextDecoration.none;
      threeDecMedium = TextDecoration.none;
      threeDecChungus = TextDecoration.none;
    });
  }

  setSize(int siz) {
    resetThreeSizes();
    setState(() {
      finalsize = siz;
      print(finalsize);
      if (finalsize == 1) {
        threeColorSmall = EqualistColors.lightGreen;
        threeDecSmall = TextDecoration.underline;
      } else if (finalsize == 2) {
        threeColorMedium = EqualistColors.lightGreen;
        threeDecMedium = TextDecoration.underline;
      } else {
        threeColorChungus = EqualistColors.lightGreen;
        threeDecChungus = TextDecoration.underline;
      }
    });
  }

  void getReadyToCreate() async {
    SharedPreferences pref = await Services.sharedprefs();
    String refresh = pref.getString("refresh_token");
    String access = pref.getString("access_token");
    String sess_id = pref.getString("session_id");
    bool recommend = values["recommendation"];
    bool async_inv = false; //always false
    bool share = values["share it to all"];
    bool disable_seq = values["disable playlist sequencing"];
    String size = "";
    if (finalsize == 1) {
      size = "small";
    }
    if (finalsize == 2) {
      size = "medium";
    }
    if (finalsize == 3) {
      size = "bigChungus";
    }
    if (finalsize == 0) {
      EasyLoading.showError('Please select a size!');
    } else {
      Map<String, dynamic> data = {};
      data["refresh_token"] = refresh;
      data["access_token"] = access;
      data["sess_id"] = sess_id;
      data["recommendation"] = recommend;
      data["async_invite"] = async_inv;
      data["share_to_all"] = share;
      data["disable_sequencing"] = disable_seq;
      data["size"] = size;
      var reqbody = json.encode(data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingScreen(
                  reqBody: reqbody,
                )),
      );
    }
  }

  //
  //
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 4,
        color: EqualistColors.darkGreen,
      ),
    );
  }

  titleGen(String key) {
    if (key == '"Fair and Square"') {
      return new Text(
        key,
        style: GoogleFonts.quicksand(
          //color: Color.fromARGB(255, 246, 188, 189), //communism
          color: Colors.white,
        ),
      );
    } else if (key == "share it to all" ||
        key == "disable playlist sequencing") {
      return new Text(
        key,
        //textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(color: Colors.white),
      );
    } else {
      return new Text(
        key,
        style: GoogleFonts.quicksand(color: Colors.white),
      );
    }
  }

  Widget _myListView(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(20.0),
      //padding: const EdgeInsets.all(5.0),
      height: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: EqualistColors.darkBackground,
        ),
      ), //       <--- BoxDecoration here
      child: new ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: EqualistColors.lightGreen,
            title: titleGen(key),
            value: values[key],
            onChanged: (bool value) {
              Services.makeSound(false);
              setState(() {
                values[key] = value;
                // if (key == '"Fair and Square"') {
                //   values["share it to all"] = value;
                //   values["disable playlist sequencing"] = value;
                // }
                // if (values["share it to all"] &&
                //     values["disable playlist sequencing"]) {
                //   values['"Fair and Square"'] = true;
                // }
                // if (!values["share it to all"] &&
                //     !values["disable playlist sequencing"]) {
                //   values['"Fair and Square"'] = false;
                // }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget inTheBox() {
    return Container(
      // margin: const EdgeInsets.all(10.0),
      // padding: const EdgeInsets.all(30.0),
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 12),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 500.0,
      decoration: myBoxDecoration(), //       <--- BoxDecoration here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            "Options:",
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(
              fontSize: 20,
              color: EqualistColors.lightGreen,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _myListView(context),
          SizedBox(
            height: 2,
          ),
          Text(
            "Size:",
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(
              fontSize: 15,
              color: EqualistColors.lightGreen,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FlatButton(
                color: Colors.transparent,
                splashColor: EqualistColors.darkBackground,
                onPressed: () {
                  setSize(1);
                },
                child: Text("Small", style: threeSizes(1)),
              ),
              FlatButton(
                color: Colors.transparent,
                splashColor: EqualistColors.darkBackground,
                onPressed: () {
                  setSize(2);
                },
                child: Text("Medium", style: threeSizes(2)),
              ),
              FlatButton(
                color: Colors.transparent,
                splashColor: EqualistColors.darkBackground,
                onPressed: () {
                  setSize(3);
                },
                child: Text("Big Chungus", style: threeSizes(3)),
              ),
            ],
          ),
          SizedBox(
            height: 23,
          ),
          ButtonTheme(
            minWidth: 300.0,
            height: 120.0,
            child: RaisedButton(
              color: EqualistColors.lightGreen,
              onPressed: () {
                getReadyToCreate();
              },
              child: Text(
                "Create Playlist",
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 15.0,
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
                    value: 0.6,
                    backgroundColor: EqualistColors.darkBackground,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        EqualistColors.lightGreen),
                  ),
                  height: 10.0,
                  //width: 20.0,
                )),
            SizedBox(
              height: 15,
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
              height: 55,
            ),
            inTheBox(),
          ],
        ),
      ),
    );
  }
}
