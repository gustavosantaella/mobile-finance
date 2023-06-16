import 'package:wafi/services/home.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  List wallets = [];
  dynamic currentWallet;
  late List history = [];
  Map metrics = {};
  bool loadingWallet = false;
  int currenIndex = 0;

  Future<dynamic> getHistroy(walletId, context) async {
    try {
      if (history.isNotEmpty) {
        return history;
      }
      await setRefreshHistory(walletId, context);
      return history;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getBalance(String walletId, BuildContext context,
      {bool force = false}) async {
    try {
      loadingWallet = true;
      await Future.delayed(const Duration(seconds: 1));

      Map response = await getWalletBalance(walletId, force: force);
      currentWallet = response;
      loadingWallet = false;
      notifyListeners();
      return currentWallet;
    } catch (e) {
     SnackBarMessage(context, Text(e.toString()));
    }
  }

  Future<List> setRefreshHistory(String walletId, context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Map response = await getHistory(walletId);
      history.clear();
      history.addAll(response['history']);
      metrics = response['metrics'];
      notifyListeners();

      return history;
    } catch (e) {
     SnackBarMessage(context, Text(e.toString()));

      rethrow;
    }
  }

  Future<List> getWallets(context) async {
    try {
      loadingWallet = true;
      List wallets = await getAllWalletsByOwner();
      this.wallets = wallets;
      loadingWallet = false;
      notifyListeners();
      return this.wallets;
    } catch (e) {
     SnackBarMessage(context, Text(e.toString()));
      rethrow;
    }
  }

  Future<void> clearAll() async {
    wallets = [];
    currentWallet = null;
    currenIndex = 0;
    history = [];


  }
}
