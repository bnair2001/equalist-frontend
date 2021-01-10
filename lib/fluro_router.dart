import 'dart:convert';
import 'package:equalist/finish.dart';
import 'package:equalist/homie.dart';
import 'package:equalist/loading.dart';
import 'package:equalist/main.dart';
import 'package:equalist/options.dart';
import 'package:equalist/services.dart';
import 'package:equalist/login.dart';
import 'package:equalist/waitingRoom.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FRouter {
  static final router = FluroRouter();

  static sendReq(var code, var state, mat.BuildContext context) async {
    EasyLoading.show(status: 'Signing you in..');
    var endpointUrl = 'https://calm-oasis-20606.herokuapp.com/callback';
    Map<String, String> queryParams = {'code': code, 'state': state};
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);
    var res = response.body;
    final Map parsed = json.decode(res);
    print("Parsed");
    print(parsed);
    String ref_token = parsed["refresh_token"];
    String access_tok = parsed["access_token"];
    SharedPreferences prefs = await Services.sharedprefs();
    var auth_res;
    if (prefs.getBool("homie")) {
      Map<String, String> data = {};
      data["refresh_token"] = ref_token;
      data["access_token"] = access_tok;
      data["url_key"] = prefs.getString("homie_key");
      String endpoint = Services.apiUrl + "add-homie/";
      print(data);
      var response = await http.post(endpoint, body: json.encode(data));
      print(response.statusCode);
      print(response.body);
      var res_homie = response.body;
      Map parsed_new = json.decode(res_homie);
      print(parsed_new);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomineAuth(
                  status: true,
                )),
      );
    } else {
      if (ref_token != null && access_tok != null) {
        //Map data = {"refresh_token": ref_token, "access_token": access_tok};
        Map<String, String> data = {};
        data["refresh_token"] = ref_token;
        data["access_token"] = access_tok;
        // data["url_key"] = prefs.getString("homie_key");
        String endpoint = Services.apiUrl + "create-session/";
        var response = await http.post(endpoint, body: json.encode(data));
        auth_res = response.body;
      } else {
        print("null token recieved");
      }
      Map parsed_new = json.decode(auth_res);
      print("Parsed 1");
      print(parsed_new);
      if (parsed_new["session_id"] != null && parsed_new["url_key"] != null) {
        await prefs.setString("session_id", parsed_new["session_id"]);
        await prefs.setString("url_key", parsed_new["url_key"]);

        router.navigateTo(context, "/waiting");
      } else {
        print("Got null session and key");
        print(auth_res);
      }
    }

    EasyLoading.dismiss();
  }

  static void handleMyHomie(var key, mat.BuildContext context) async {
    SharedPreferences prefs = await Services.sharedprefs();
    prefs.setBool("homie", true);
    prefs.setString("homie_key", key);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static Handler _homeHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    var code = params['code']?.first;
    var state = params['state']?.first;
    print(code);
    if (code != null && state != null) {
      sendReq(code, state, context);
    } else {
      print("No state or code");
    }
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
      redirect: true,
    );
  });

  static Handler _homieHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    var key = params['key']?.first;
    if (key != null) {
      handleMyHomie(key, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return HomineAuth();
  });

  static Handler _waitingHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return WaitingRoom();
  });

  static Handler _loadingHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return LoadingScreen();
  });

  static Handler _optionsHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return OptionsPage();
  });

  static Handler _finishHandler = Handler(
      handlerFunc: (mat.BuildContext context, Map<String, dynamic> params) {
    //var code = params['code']?.first;
    //var account = params['account']?.first;
    //print(code);
    // Use name and account values
    return FinishPage();
  });

  static void setupRouter() {
    router.define("login", handler: _homeHandler);
    router.define("verify", handler: _verifyHandler);
    router.define("waiting", handler: _waitingHandler);
    router.define("options", handler: _optionsHandler);
    router.define("loading", handler: _loadingHandler);
    router.define("finish", handler: _finishHandler);
    router.define("homie", handler: _homieHandler);
  }
}
