import 'dart:convert';

import 'package:http/http.dart';
import 'package:wafi/config/constanst.dart';

Future<Map<String, dynamic>> getCurrenciesApi() async {
  try {
    Response response = await get(Uri.parse("$currencyApi/currencies"),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> res = json.decode(response.body);
    return res;
  } catch (e) {
    rethrow;
  }
}

Future<double> getConversion(String fromConvert, String toConvert, String amount) async {
  try {
    Response response = await get(Uri.parse("$currencyApi/currencies/conversion?qoute=$toConvert&base=$fromConvert&amount=$amount"),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> res = json.decode(response.body);

    print(res);
    return res['converted'];
  } catch (e) {
    rethrow;
  }
}
