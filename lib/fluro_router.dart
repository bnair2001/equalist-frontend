import 'package:equalist/main.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as mat;

class FRouter {
  static final router = FluroRouter();

  static Handler _homeHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    var code = params['code']?.first;
    //var account = params['account']?.first;
    print(code);
    // Use name and account values
    return MyHomePage(
      title: "Equalist",
    );
  });
  static void setupRouter() {
    router.define("login", handler: _homeHandler);
  }
}
