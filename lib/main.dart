import 'package:equalist/colors.dart';
import 'package:equalist/fluro_router.dart';
import 'package:equalist/login.dart';
import 'package:equalist/services.dart';
import 'package:equalist/waitingRoom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  configureApp();
  FRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equalist',
      initialRoute: 'verify',
      onGenerateRoute: FRouter.router.generator,
      builder: EasyLoading.init(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Equalist',
        redirect: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.redirect}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final bool redirect;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //verifyLogin();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    transfer(bool login) {
      if (login) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => WaitingRoom()),
        // );
        FRouter.router.navigateTo(context, "/waiting");
      } else {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginPage()),
        // );
        FRouter.router.navigateTo(context, "/login");
      }
    }

    verifyLogin() async {
      bool login = await Services.checkLogin();
      if (login) {
        SharedPreferences prefs = await Services.sharedprefs();
        print("From home");
        print(prefs.getString("session_id"));
        print(prefs.getString("url_key"));
        transfer(true);
      } else {
        print("no login");
        transfer(false);
      }
    }

    if (widget.redirect) {
      verifyLogin();
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
