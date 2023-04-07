import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  Widget printWallets(Map wallet, WalletProvider provider) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            // height: 100,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(100, 100, 100, .2),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  )
                ],
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
            child: provider.loadingWallet == true
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.currentWallet['info']['currency'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 30),
                          ),
                          IconButton(
                            onPressed: () {
                              print(2);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        'Balance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "\$.${provider.currentWallet['balance'].toString()}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Incomes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '\$.${provider.currentWallet["incomes"]}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Expenses',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '\$.${provider.currentWallet["expenses"]}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.red),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )));
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (walletProvider.wallets.isEmpty && context.mounted) {
      walletProvider.getWallets(userProvider.userId, context);
    }
    if (context.mounted && walletProvider.currentWallet == null) {
      if (walletProvider.wallets.isNotEmpty) {
        walletProvider.loadingWallet = true;
        walletProvider.loadingHistory = true;
        walletProvider.getBalance(walletProvider.wallets[0]['_id'], context);
        walletProvider.setRefreshHistory(walletProvider.wallets[0]['_id']);
      }
    }
    return Consumer(
        builder: (context, value, child) => CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.93,
                onPageChanged: (index, reason) async {
                  walletProvider.loadingWallet = true;
                  walletProvider.getBalance(
                      walletProvider.wallets[index]['_id'], context);
                  walletProvider.currentWallet['index'] = index;
                  walletProvider.loadingHistory = true;
                  walletProvider.notifyListeners();
                  await walletProvider
                      .setRefreshHistory(walletProvider.wallets[index]['_id']);
                }),
            items: walletProvider.wallets.map((wallet) {
              return Builder(
                builder: (context) {
                  return printWallets(wallet, walletProvider);
                },
              );
            }).toList()));
  }
}
