import 'dart:convert';

import 'package:http/http.dart';
import "package:finance/config/constanst.dart";
import 'auth.dart';

Future<Map> getHistoryByDate(String walletId, {date, field}) async {
  try {
    final String token = await getuserToken(formatted: true);
    Response response = await get(
        Uri.parse("$url/wallet/history/$walletId?$field=$date"),
        headers: {"Authorization": token});

    Map res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw res['message'];
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}
