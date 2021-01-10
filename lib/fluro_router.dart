import 'package:equalist/main.dart';
import 'package:equalist/options.dart';
import 'package:equalist/services.dart';
import 'package:equalist/login.dart';
import 'package:equalist/waitingRoom.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as mat;
import 'package:shared_preferences/shared_preferences.dart';

class FRouter {
  static final router = FluroRouter();

  static Handler _homeHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    var code = params['code']?.first;
    //var account = params['account']?.first;
    print(code);

    // Use name and account values
    return LoginPage();
  });

  static Handler _verifyHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return MyHomePage(
      title: "Equalist",
    );
  });

  static Handler _waitingHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return WaitingRoom();
  });

  static Handler _optionsHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return OptionsPage();
  });

  static void setupRouter() {
    router.define("login", handler: _homeHandler);
    router.define("verify", handler: _verifyHandler);
    router.define("waiting", handler: _waitingHandler);
    router.define("options", handler: _optionsHandler);
  }
}
