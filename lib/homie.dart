import 'package:equalist/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomineAuth extends StatefulWidget {
  HomineAuth({Key key}) : super(key: key);

  @override
  _HomineAuthState createState() => _HomineAuthState();
}

class _HomineAuthState extends State<HomineAuth> {
  @override
  Widget build(BuildContext context) {
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
              height: 15.0,
            ),
            Text(
              "Please wait..",
              style: GoogleFonts.pressStart2p(
                  fontSize: 10, color: EqualistColors.white),
            )
          ],
        ),
      ),
    );
  }
}
