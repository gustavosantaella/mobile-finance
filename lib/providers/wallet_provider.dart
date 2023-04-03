import 'package:finance/pages/home/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletProvider extends ChangeNotifier {
  dynamic walletS;
  late List history = [];

  dynamic errorMessage;

  Future<dynamic> getHistroy(walletId) async {
    try {
      if (history.isNotEmpty) {
        return history;
      }
      await setRefreshHistory(walletId);
      return history;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }



  Future<List> setRefreshHistory(String walletId) async {
    try {
      await Future.delayed(const Duration(seconds: 10));
      var history = await getHistory(walletId);
      this.history = history;
      notifyListeners();

      return this.history;
    } catch (e) {
      print("error");
      rethrow;
    }
  }

}
