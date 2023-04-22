import 'package:finance/services/home.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  List wallets = [];
  dynamic currentWallet;
  late List history = [];
  bool loadingHistory = false;
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

  Future<dynamic> getBalance(String walletId, BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      Map response = await getWalletBalance(walletId);
      currentWallet = response;
      loadingWallet = false;
      notifyListeners();
      return currentWallet;
    } catch (e) {
      SnackBarMessage(context, Colors.red, Text(e.toString()));
    }
  }

  Future<List> setRefreshHistory(String walletId, context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Map response = await getHistory(walletId);
      history.clear();
      history.addAll(response['history']);
      loadingHistory = false;
      notifyListeners();

      return history;
    } catch (e) {
      SnackBarMessage(context, Colors.red, Text(e.toString()));

      rethrow;
    }
  }

  Future<List> getWallets(userId, context) async {
    try {
      List wallets = await getAllWalletsByOwner(userId);
      this.wallets = wallets;
      notifyListeners();
      return this.wallets;
    } catch (e) {
      SnackBarMessage(context, Colors.red, Text(e.toString()));
      rethrow;
    }
  }
}
