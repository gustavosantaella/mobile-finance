import 'package:finance/config/constanst.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

getValue(dynamic num) {
  if (num != null) {
    if (num > 0.001) {
      return num;
    }
  }

  return 0;
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  Widget printWallets(Map wallet, WalletProvider provider, context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
            padding: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: normalShadow,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            provider.loadingWallet = true;
                            provider.getBalance(
                                provider.currentWallet['info']["walletId"],
                                context);
                            provider.notifyListeners();
                          },
                          icon: Icon(Icons.refresh)),
                      IconButton(
                          onPressed: () async {
                            provider.loadingWallet = true;
                            provider.getBalance(
                                provider.currentWallet['info']["walletId"],
                                context);
                            provider.notifyListeners();
                          },
                          icon: Icon(Icons.settings)),
                      IconButton(
                          onPressed: () async {
                            provider.loadingWallet = true;
                            provider.getBalance(
                                provider.currentWallet['info']["walletId"],
                                context);
                            provider.notifyListeners();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return AspectRatio(
                                aspectRatio: 1.5,
                                child: PieChart(
                                  PieChartData(sections: [
                                    PieChartSectionData(
                                        titleStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        value: getValue(provider
                                                        .metrics['incomes'])
                                                    .toInt() <=
                                                0
                                            ? 0.001
                                            : getValue(
                                                provider.metrics['incomes']),
                                        title:
                                            "${getValue(provider.metrics['incomes'])}%",
                                        color: Colors.blue),
                                    PieChartSectionData(
                                        titleStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        value: getValue(provider
                                                        .metrics['expenses'])
                                                    .toInt() <=
                                                0
                                            ? 0.001
                                            : getValue(
                                                provider.metrics['expenses']),
                                        title:
                                            "${getValue(provider.metrics['expenses'])}%",
                                        color: Colors.red),
                                  ]),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 130,
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                Text(
                                  "${provider.currentWallet?["info"]?["currency"] ?? "Loading..."}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                    "\$.${provider.currentWallet?["balance"] ?? 0}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23)),
                                const Text("Balance",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          )
                        ],
                      )),
                      const SizedBox(
                        width: 0,
                      ),
                      SizedBox(
                        width: 140,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.arrow_downward_outlined,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "Expenses",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                        '\$.${provider.currentWallet?["expenses"] ?? 0}',
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "Expenses",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                        '\$.${provider.currentWallet?["incomes"] ?? 0}',
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: true);
    if (walletProvider.wallets.isEmpty && context.mounted) {
      walletProvider.getWallets(context);
    }
    if (context.mounted && walletProvider.currentWallet == null) {
      if (walletProvider.wallets.isNotEmpty) {
        walletProvider.getBalance(walletProvider.wallets[0]['_id'], context);
        walletProvider.setRefreshHistory(
            walletProvider.wallets[0]['_id'], context);
      }
    }
    return Consumer(
        builder: (context, value, child) => CarouselSlider(
            options: CarouselOptions(
                initialPage: walletProvider.currenIndex,
                enableInfiniteScroll: false,
                viewportFraction: 0.90,
                onPageChanged: (index, reason) async {
                  walletProvider.loadingWallet = true;
                  walletProvider.getBalance(
                      walletProvider.wallets[index]['_id'], context);
                  walletProvider.currenIndex = index;
                  walletProvider.notifyListeners();
                  await walletProvider.setRefreshHistory(
                      walletProvider.wallets[index]['_id'], context);
                }),
            items: walletProvider.wallets.map((wallet) {
              return Builder(
                builder: (context) {
                  return printWallets(wallet, walletProvider, context);
                },
              );
            }).toList()));
  }
}
