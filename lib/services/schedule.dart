import 'dart:convert';

import 'package:finance/config/constanst.dart';
import 'package:finance/services/auth.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
Future<void> add(BuildContext context, Map data) async {
  try {
    String token = await getuserToken(formatted: true);
    await post(Uri.parse("$url/wallet/history/schedule/add"),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json", "Authorization": token});
  } catch (e) {
    SnackBarMessage(context, Colors.red, Text(e.toString()));
    rethrow;
  }
}


Future<List> getSchedules(BuildContext context, String walletId) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await get(Uri.parse("$url/wallet/history/schedule/by-wallet/$walletId"),
        headers: {"Content-Type": "application/json", "Authorization": token});

    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res['message']);
    }
    return res['data'];
  } catch (e) {
    SnackBarMessage(context, Colors.red, Text(e.toString()));
    rethrow;
  }
}


Future<bool> deleteSchedule(BuildContext context, String schedulePk) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await delete(Uri.parse("$url/wallet/history/schedule/delete/$schedulePk"),
        headers: {"Content-Type": "application/json", "Authorization": token});

    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res['message']);
    }
    return true;
  } catch (e) {
    SnackBarMessage(context, Colors.red, Text(e.toString()));
    rethrow;
  }
}
