import 'dart:async';
import 'dart:convert';

import 'package:Appetize/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class API {
  static submitProfile() async {
    String url = 'http://10.0.2.2:5050/api/profile';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };

    String profile =
        json.encode({"id": "APPETIZE_0", "vote": foodRating.value});

    statusText.value = 'Tack för din feedback!';

    apiTimeout = Timer(Duration(seconds: 1), () {
      if (deliverStatus.value == 1) deliverStatus.value = 0;
    });

    try {
      await post(url, headers: headers, body: profile);
      apiTimeout.cancel();
      deliverStatus.value = 2;
    } catch (_) {
      deliverStatus.value = 0;
    }
  }

  static getProfile() async {}
}
