import 'dart:async';
import 'dart:convert';

import 'package:Appetize/Preferences.dart';
import 'package:Appetize/globals.dart';
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

    apiTimeout = Timer(Duration(seconds: 1), () {
      if (deliverStatus.value == 1) deliverStatus.value = 0;
    });

    try {
      await _post(
          '/api/profile', {"id": "APPETIZE_0", "vote": foodRating.value});
      apiTimeout.cancel();
      deliverStatus.value = 2;
    } catch (_) {
      deliverStatus.value = 0;
    }
  }

  static logout() {
    appetizeId = '';
    savePreferences();
    navigatorKey.currentState.pushNamed('/');
  }

  static getProfile() async {
    String url = API_ENDPOINT + "/api/profile?id=" + appetizeId;
    Response response = await get(url);
    Map body = json.decode(response.body);
    if (body['success']) {
      eatTime.value = body['profile']['time'];
      restaurant.value = body['profile']['restaurant'];

      navigatorKey.currentState.pushNamed('/home');
    } else {
      navigatorKey.currentState.pushNamed('/');
    }
  }

  static signup(code) async {
    // Temporary backdoor, remove it once we have a server!
    if (code == '0000') {
      navigatorKey.currentState.pushNamed('/home');
      return;
    }

    try {
      var response = await _post('/api/signup', {"code": code});

      var res = json.decode(response.body);

      if (res["success"]) {
        appetizeId = res["id"];
        await savePreferences();
        getProfile();
        //navigatorKey.currentState.pushNamed('/home');
      } else {
        signupStatus.value = res["text"];
      }
    } catch (_) {}
  }
}
