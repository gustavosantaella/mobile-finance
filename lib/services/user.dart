import 'dart:convert';
import 'dart:ffi';

import 'package:finance/config/constanst.dart';
import 'package:finance/services/auth.dart';
import 'package:http/http.dart';

Future<Map> getUser() async {
  String token = await getuserToken(formatted: true);

  Response response = await get(Uri.parse("$url/users/info"),
      headers: {"Authorization": token});

  Map res = jsonDecode(response.body);

  if (res['ok'] != ok) {
    throw Exception(res['error']);
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
      throw Exception(res['error']);
    }
    return res['data'] as bool;
  } catch (e) {
    rethrow;
  }
}
