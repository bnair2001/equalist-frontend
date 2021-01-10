import 'package:equalist/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsPage extends StatefulWidget {
  OptionsPage({Key key}) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
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
              height: 90,
            ),
            //inTheBox(),
          ],
        ),
      ),
    );
  }
}
