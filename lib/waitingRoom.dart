import 'package:equalist/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingRoom extends StatefulWidget {
  WaitingRoom({Key key}) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
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
            border: Border.all(color: EqualistColors.lightGreen),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Loding link...',
                style: GoogleFonts.quicksand(
                  color: EqualistColors.white,
                ),
              ),
              Text('        '),
              Icon(
                Icons.copy,
                color: EqualistColors.lightGreen,
              ),
            ],
          ));
    }

    Widget inTheBox() {
      return Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(50.0),
        height: 450.0,
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
            SizedBox(
              height: 20,
            ),
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
                Text('                  '),
                Icon(
                  Icons.refresh,
                  color: EqualistColors.lightGreen,
                ),
              ],
            ),

            ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                color: EqualistColors.lightGreen,
                onPressed: null,
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
                    value: 0.5,
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
