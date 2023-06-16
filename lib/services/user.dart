import 'dart:convert';

import 'package:wafi/config/constanst.dart';
import 'package:wafi/services/auth.dart';
import 'package:http/http.dart';

Future<Map> getUser() async {
  
    String token = await getuserToken(formatted: true);

  Response response = await get(Uri.parse("$url/users/info"),
      headers: {"Authorization": token});

  Map res = jsonDecode(response.body);
  if (res['ok'] != ok) {
    throw Exception(res['message']);
  }

  return res['data'];
  
}

Future<bool> updateUserInfro(data) async {
  try {
    String token = await getuserToken(formatted: true);

    Response response = await put(Uri.parse("$url/users/info"),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode(data));

    Map res = jsonDecode(response.body);

    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
    return res['data'] as bool;
  } catch (e) {
    rethrow;
  }
}
