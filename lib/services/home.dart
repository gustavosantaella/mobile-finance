import 'dart:convert';
import 'package:finance/config/constanst.dart';
import 'package:finance/database/main.dart';
import 'package:finance/helpers/fn/main.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
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

Future<bool> addTohistory(String amount, String description, String category,
    dynamic type, String walletId,
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
      "walletId": walletId.trim()
    };
    await http.post(Uri.parse("$url/financial/history/"),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode(jsonBody));
    return true;
  } catch (e) {
    rethrow;
  }
}

Future<Map> getHistory(String walletId) async {
  try {
    String token = await getuserToken(formatted: true);
    final data =
        await http.get(Uri.parse("$url/financial/history/$walletId"), headers: {
      "Authorization": token,
    });
    Map decode = jsonDecode(data.body);
    if (data.statusCode != 200) {
      throw decode['error'];
    }
    return decode['data'];
  } catch (e) {
    rethrow;
  }
}

Future<List> getAllWalletsByOwner({bool force = false}) async {
  try {
    String token = await getuserToken(formatted: true);
    dynamic response = await http.get(Uri.parse("$url/wallet/by-owner"),
        headers: {"Authorization": token});
    response = jsonDecode(response.body);
    if (response['status'] != 200) {
      throw "Error to get wallets";
    }
    return response['data'];
  } catch (e) {
    rethrow;
  }
}

Future<Map> getWalletBalance(String walletId, {bool force = false}) async {
  try {
    Database db = await DB().openDB();
    Map data = {};
    List wallet = await db
        .rawQuery('select data from wallets where walletId=?', [walletId]);
    if (wallet.isNotEmpty && !force) {
      
      data = json.decode(wallet[0]['data']);
    } else {
      String token = await getuserToken(formatted: true);
      dynamic response = await http.get(Uri.parse("$url/wallet/$walletId"),
          headers: {"Authorization": token});
      response = jsonDecode(response.body) as Map;
      if (response['status'] != 200) {
        throw response['error'];
      }

      data = response['data'];
      try {
        await db.rawInsert('insert into wallets(walletId, data) values (?,?)',
            [walletId, json.encode(data)]);
      } catch (e) {
        print('error to insert');
      }
    }

    return data;
  } catch (e) {
    rethrow;
  }
}
