import 'dart:convert';
import 'dart:ui';
import 'package:finance/config/constanst.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'auth.dart';

Logger logger = Logger();

Future<List> getCategoriest() async {
  try {
    String token = await getuserToken(formatted: true);
    String lang = window.locale.languageCode;
    var data = await http.get(
      Uri.parse("$url/categories?lang=$lang"),
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
    Box historyCollection = await Hive.openBox('history');
    bool updateHistory = false;
    if (historyCollection.isNotEmpty) {
      int index = historyCollection.values
          .toList()
          .indexWhere((element) => element['walletId'] == walletId);
      if (index > -1) {
        updateHistory = true;
      }
    }
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
    await http.post(Uri.parse("$url/wallet/history/"),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode(jsonBody));
    if (updateHistory) {
      List<Future> futures = [
        getWalletBalance(walletId, force: true),
        getHistory(walletId, force: true),
       ].toList();
      
      await Future.wait(futures);
    }
    return true;
  } catch (e) {
    rethrow;
  }
}

Future<Map> getHistory(String walletId, {bool force = false}) async {
  try {
    Box historyCollection = await Hive.openBox('history');
    dynamic index;
    if (historyCollection.isNotEmpty) {
      index = historyCollection.values
          .toList()
          .indexWhere((element) => element['walletId'] == walletId);
      if (index > -1 && force == false) {
        logger.i('offline history');
        return historyCollection.getAt(index);
      }
    }
    String token = await getuserToken(formatted: true);
    final data =
        await http.get(Uri.parse("$url/wallet/history/$walletId"), headers: {
      "Authorization": token,
    });
    Map decode = jsonDecode(data.body);
    if (data.statusCode != 200) {
      throw decode['error'];
    }

    if (index != null) {
      historyCollection.putAt(index, decode['data']);
    } else {
      historyCollection.add(decode['data']);
    }
    return decode['data'];
  } catch (e) {
    rethrow;
  }
}

Future<List> getAllWalletsByOwner({bool force = false}) async {
  try {
    Box walletCollection = await Hive.openBox('wallets');
    if (walletCollection.isNotEmpty && force == false) {
      var w = walletCollection.values.toList();
      return w;
    }
    String token = await getuserToken(formatted: true);
    logger.i("online wallets");
    dynamic response = await http.get(Uri.parse("$url/wallet/by-owner"),
        headers: {"Authorization": token});
    response = jsonDecode(response.body);
    if (response['status'] != 200) {
      throw "Error to get wallets";
    }
    await walletCollection.addAll(response['data']);
    return response['data'];
  } catch (e) {
    rethrow;
  }
}

Future<Map> getWalletBalance(String walletId, {bool force = false}) async {
  try {
    Box walletCollection = await Hive.openBox('wallets');
    Map data = {};
    dynamic wallet;
    dynamic index;
    if (walletCollection.isNotEmpty) {
      index = walletCollection.values
          .toList()
          .indexWhere((element) => element['_id'] == walletId);
      wallet = walletCollection.get(index);
      if (wallet['balance'] != 0 && force == false) {
        logger.i('offline balance');
        return wallet['balance'];
      }
    }
     logger.w('online balance');
    String token = await getuserToken(formatted: true);

    dynamic response = await http.get(Uri.parse("$url/wallet/$walletId"),
        headers: {"Authorization": token});
    response = jsonDecode(response.body) as Map;

    if (response['status'] != 200) {
      throw response['error'];
    }
    data = response['data'];
    logger.i(data);
    if (index != null && wallet != null) {
      walletCollection.putAt(index, {
        ...wallet,
        'balance': data,
      });
    }

    index = null;
    wallet = null;

    return {...data, };
  } catch (e) {
    logger.e(e.toString());
    rethrow;
  }
}
