import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/services/auth.dart';
import 'package:http/http.dart';
import 'package:wafi/widgets/snack_bar.dart';

const String _prefix = "wallet/history";
Logger logger = Logger();
Future<Map> historyDetail(String id, String walletId) async {
  String token = await getuserToken(formatted: true);
  Response response = await get(Uri.parse("$url/$_prefix/detail/$id"),
      headers: {"Authorization": token});

  Map res = jsonDecode(response.body);

  if (res['ok'] != ok) {
    throw Exception([res['message']]);
  }

  return res['data'];
}

Future<void> deleteHistory(context, {required String historyId}) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await delete(
        Uri.parse("$url/$_prefix/delete/$historyId"),
        headers: {"Authorization": token});

    Map res = jsonDecode(response.body);

    if (res['ok'] != ok) {
      throw Exception([res['message']]);
    }
  } catch (e) {
    logger.wtf(e.toString());
    logger.wtf(url);
    SnackBarMessage(context, e.toString());
  }
}

Future<void> restoreHistoryMovements(BuildContext context,
    {required String walletPk}) async {
  try {
    String? token = await getuserToken(formatted: true);
    Response response =
        await delete(Uri.parse("$url/$_prefix/restore/$walletPk"), headers: {
          "Authorization": token
        });
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
  } catch (e) {
    SnackBarMessage(context, e.toString());
    rethrow;
  }
}
