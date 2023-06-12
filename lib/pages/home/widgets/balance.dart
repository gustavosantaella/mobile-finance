import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/providers/drawe_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

getValue(dynamic num) {
  if (num != null) {
    if (double.parse(num) > 0.001) {
      return double.parse(num);
    }
  }

  return 0;
}


Logger logger = Logger();

class BalanceWidget extends StatelessWidget  {
  const BalanceWidget({Key? key}) : super(key: key);
  Widget printWallets(Map wallet, WalletProvider provider, context) {
    return Builder(builder: (context) {
            final drawerProvider = Provider.of<DrawerProvider>(context);

      return SingleChildScrollView(
        child: provider.loadingWallet == true
            ? const CircularProgressIndicator()
            : Column(
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
                                provider.currentWallet['info']["_id"], context,
                                force: true);
                              // provider.setRefreshHistory( provider.currentWallet['info']["_id"], context,);
                            provider.notifyListeners();
                          },
                          icon: const Icon(Icons.refresh)),
                      IconButton(
                          onPressed: () async {
                            
                            Navigator.pushNamed(context, '/schedules');
                            
                          },
                          icon: const Icon(Icons.punch_clock_sharp)),
                      // IconButton(
                      //     onPressed: () async {
                      //       provider.loadingWallet = true;
                      //       provider.getBalance(
                      //           provider.currentWallet['info']["_id"], context);
                      //       provider.notifyListeners();
                      //     },
                      //     icon: const Icon(
                      //       Icons.delete,
                      //       color: Colors.red,
                      //     )),
                   
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
                                aspectRatio: 1,
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
                                        color: const Color.fromARGB(
                                            132, 36, 219, 42)),
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
                                        color: const Color.fromARGB(
                                            136, 244, 67, 54)),
                                  ]),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 120,
                            child: Wrap(
                              direction: Axis.vertical,
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
                                  children: [
                                    const Icon(
                                      Icons.arrow_downward_outlined,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      lang('expenses'),
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
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
                                        textAlign: TextAlign.center,
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
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      lang('incomes'),
                                      style: const TextStyle(
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
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: true);

    if (walletProvider.wallets.isEmpty && context.mounted) {
      walletProvider.getWallets(context);
    }
    if (context.mounted &&
        walletProvider.currentWallet == null &&
        walletProvider.loadingWallet == false) {
      if (walletProvider.wallets.isNotEmpty) {
        walletProvider.getBalance(walletProvider.wallets[0]['_id'], context);
        walletProvider.setRefreshHistory(
            walletProvider.wallets[0]['_id'], context);
      }
    }
    return Container(
        margin: marginAll,
        height: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.all(1),
        constraints: const BoxConstraints(
          minHeight: 1.0,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: normalShadow,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: CarouselSlider(
            options: CarouselOptions(
                initialPage: walletProvider.currenIndex,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                height: MediaQuery.of(context).size.height / 2.5,
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
