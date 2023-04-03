import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

// TODO: REFACTOR THIS
const String url = 'http://10.0.2.2:8000/api';

//  TODO: REMOVE HARD-CDOE AND REPLACE BY DYNAMIC TOKEN
const String token =  "Wafi eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDI4NTYzOWNiNmY2MWQzMzRmNGU1MGUifQ.IWGhoM4Lby4NnAL7vwnsbZeAkRzdSZz08NIwJ7il8SI";

Future<List> getCategoriest() async {
  try {
    var data = await http.get(
      Uri.parse("$url/categories"),
      headers: {
        "Authorization": token
      },
    );
    var payload = jsonDecode(data.body);
    if (data.statusCode != 200) {
      throw payload['error'];
    }
    return payload['data'];
  } catch (e) {
    throw e.toString();
  }
}

Future<bool> addTohistory(
    String amount, String description, String category, dynamic type,
    {String provider = 'WAFI'}) async {
  try {
    final jsonBody = {
      "type": type is bool
          ? type == true
              ? 'expense'
              : 'income'
          : type.toString().trim(),
      "value": amount,
      "description": description.trim(),
      "categoryId": category.trim(),
      "provider": provider.trim(),
      "walletId": "6428550c474acb036e24f579".trim()
    };
    await http.post(Uri.parse("$url/financial/history/"),
        headers: {
          "Authorization":
              "Wafi eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDI4NTYzOWNiNmY2MWQzMzRmNGU1MGUifQ.IWGhoM4Lby4NnAL7vwnsbZeAkRzdSZz08NIwJ7il8SI",
          "Content-Type": "application/json"
        },
        body: jsonEncode(jsonBody));
    return true;
  } catch (e) {
    rethrow;
  }
}

Future<List> getHistory(String walletId) async {
  try {
    // TODO: remove hard-code walletId in query params
    final data = await http
        .get(
          Uri.parse("$url/financial/history/6428550c474acb036e24f579"),
          headers: {
            "Authorization": token
          });

      Map decode = jsonDecode(data.body);
      if(data.statusCode != 200){
        throw decode['error'];
      }
    return decode['data'];
  } catch (e) {
    print(e.toString());
    print("An error ocurred");
    rethrow;
  }
}
