import 'dart:convert';

import 'package:http/http.dart';
import "package:finance/config/constanst.dart";
import 'auth.dart';

Future<List> getHistoryByDate(String walletId, DateTime date) async {
  try {
    final String token = await getuserToken(formatted: true);
    Response response = await get(
        Uri.parse("$url/financial/history/$walletId?month=${date.month}"),
        headers: {"Authorization": token});

    Map res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw res['error'];
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}
