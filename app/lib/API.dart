import 'dart:convert';

import 'package:Appetize/globals.dart';
import 'package:http/http.dart';

class API {
  static submitProfile() async {
    String url = 'http://10.0.2.2:5050/api/profile';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };

    JsonEncoder encoder = JsonEncoder();
    String profile =
        json.encode({"id": "APPETIZE_0", "vote": foodRating.value});

    Response response = await post(url, headers: headers, body: profile);
    print(response.body.toString());
  }
}
