import 'dart:convert';

import 'package:http/http.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/services/auth.dart';

Future<List> getLoansByType(bool isLoan) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await get(
        Uri.parse("$url/loans/by-user-type?type=$isLoan"),
        headers: {"Authorization": token});

    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}

Future<void> deleteLoan(String loanPk) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await delete(Uri.parse("$url/loans/remove/$loanPk"),
        headers: {"Authorization": token});

    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}

Future<void> updateStatus(String status, String loanPk) async {
  try {
    String token = await getuserToken(formatted: true);
    Response response = await put(Uri.parse("$url/loans/update-status/$loanPk"),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode({"status": status}));

    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}

Future<Map> newLoan(Map payload) async {
  logger.d(jsonEncode(payload));
  try {
    if (payload.isEmpty) {
      throw Exception("Empty payload");
    }
    String token = await getuserToken(formatted: true);
    Response response = await post(Uri.parse("$url/loans/new"),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode({
          "amount": payload['amount'],
          "walletPk": payload['walletPk'],
          "description": payload['description'],
          'categoryPk': payload['categoryPk'],
          "isLoan": payload['isLoan'],
          "who": payload['who'],
          "extra": payload['extra']
        }));

    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message']);
    }
    return res['data'];
  } catch (e) {
    rethrow;
  }
}
