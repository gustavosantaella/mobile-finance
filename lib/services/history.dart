import 'dart:convert';

import 'package:finance/config/constanst.dart';
import 'package:finance/services/auth.dart';
import 'package:http/http.dart' ;

Future<Map> historyDetail(String id, String walletId) async {

  String token = await getuserToken(formatted: true);
  
  Response response = await get(Uri.parse("$url/wallet/history/detail/$id"), headers: {
    "Authorization": token
  });

  Map res = jsonDecode(response.body);

  if(res['ok'] != ok){
    throw Exception([res['error']]);
  }
  
  return res['data'];
}