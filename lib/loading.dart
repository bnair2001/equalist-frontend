import 'dart:convert';

import 'package:equalist/colors.dart';
import 'package:equalist/finish.dart';
import 'package:equalist/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key, this.reqBody}) : super(key: key);

  final reqBody;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  createPlaylist(var rqbdy) async {
    String endpoint = Services.apiUrl + "create-playlist/";
    var response = await http.post(endpoint, body: rqbdy);
    final Map parsed = json.decode(response.body);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FinishPage(
          result: parsed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var reqbody = widget.reqBody;
    createPlaylist(reqbody);
    return Scaffold(
      backgroundColor: EqualistColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: new AssetImage("assets/loading.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
