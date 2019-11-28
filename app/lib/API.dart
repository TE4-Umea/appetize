import 'dart:async';
import 'dart:convert';

import 'package:Appetize/Preferences.dart';
import 'package:Appetize/globals.dart';
import 'package:Appetize/globals.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class API {
  static _post(String path, Map body) async {
    String url = API_ENDPOINT + path;
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };

    return post(url, headers: headers, body: json.encode(body));
  }

  static submitProfile() async {
    statusText.value = 'Tack för din feedback!';
    deliverStatus.value = 1;
    apiTimeout = Timer(Duration(seconds: 3), () {
      if (deliverStatus.value == 1) deliverStatus.value = 0;
    });

    try {
      await _post('/api/profile', {
        "id": appetizeId,
        "vote": foodRating.value,
        "comments": complaints.value,
        "notified_staff": notifiedStaff.value,
        "special": {
          "veg": vegetarian.value,
          "gluten": gluten.value,
        },
      });
      apiTimeout.cancel();
      deliverStatus.value = 2;
    } catch (_) {}
    getProfile();
  }

  static logout() {
    loggedIn = false;
    appetizeId = '';
    savePreferences();
    navigatorKey.currentState
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  static getProfile() async {
    String url = API_ENDPOINT + "/api/profile?id=" + appetizeId;
    Response response = await get(url);
    Map body = json.decode(response.body);
    if(response.statusCode == 200) apiConnection.cancel();
    if (body['success']) {
      eatTime.value = body['profile']['time'];
      restaurant.value = body['profile']['restaurant'];
      open.value = body['open'];

      if (body['profile']['hasForm']) {
        deliverStatus.value = 2;
        foodRating.value = body['form']['rating'];
        complaints.value = body['form']['comments'];
        notifiedStaff.value =
            body['form']['notified_staff'] == 1 ? true : false;
      }

      if (!loggedIn)
        navigatorKey.currentState
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      loggedIn = true;
    } else {
      navigatorKey.currentState.pushNamed('/');
    }
  }

  static signup(code) async {
    try {
      var response = await _post('/api/signup', {"code": code});

      var res = json.decode(response.body);

      if (res["success"]) {
        appetizeId = res["id"];
        await savePreferences();
        getProfile();
        /* navigatorKey.currentState
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false); */
        //navigatorKey.currentState.pushNamed('/home');
      } else {
        signupStatus.value = res["text"];
      }
    } catch (_) {}
  }
}
