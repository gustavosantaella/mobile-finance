import 'package:finance/services/home.dart';
import 'package:flutter/material.dart';


class WalletDTO{
List wallets = [];
late List history = [];

WalletDTO();

}

class WalletProvider extends ChangeNotifier {
  dynamic walletS;
  late List history = [];


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
    
      var history = await getHistory(walletId);;
      this.history = history;
      notifyListeners();

      return this.history;
    } catch (e) {
      print("error");
      rethrow;
    }
  }

}
