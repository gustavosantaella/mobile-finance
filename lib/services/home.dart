import 'dart:convert';
import 'package:finance/config/constanst.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

Future<List> getCategoriest() async {
  try {
    String token = await getuserToken(formatted: true);

    var data = await http.get(
      Uri.parse("$url/categories"),
      headers: {"Authorization": token},
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
    String token = await getuserToken(formatted: true);

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
          "Authorization": token,
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
    String token = await getuserToken(formatted: true);
    final data = await http.get(
        Uri.parse("$url/financial/history/6428550c474acb036e24f579"),
        headers: {
          "Authorization": token,
        });

    Map decode = jsonDecode(data.body);
    if (data.statusCode != 200) {
      throw decode['error'];
    }
    return decode['data'];
  } catch (e) {
    print("An error ocurred");
    rethrow;
  }
}
