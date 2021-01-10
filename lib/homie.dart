import 'package:equalist/colors.dart';
import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomineAuth extends StatefulWidget {
  HomineAuth({Key key, this.status}) : super(key: key);

  final bool status;
  @override
  _HomineAuthState createState() => _HomineAuthState();
}

class _HomineAuthState extends State<HomineAuth> {
  resetHomieStatus() async {
    SharedPreferences pref = await Services.sharedprefs();
    pref.setBool("homie", false);
  }

  bool state = true;
  @override
  Widget build(BuildContext context) {
    if (widget.status == null) {
      setState(() {
        state = false;
      });
    } else {
      setState(() {
        state = widget.status;
      });
    }
    if (state) {
      resetHomieStatus();
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
              height: 15.0,
            ),
            state
                ? Text(
                    "You were succesfully added to your friend's playlist",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                        fontSize: 10, color: EqualistColors.white),
                  )
                : Text(
                    "Please wait..",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                        fontSize: 10, color: EqualistColors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
