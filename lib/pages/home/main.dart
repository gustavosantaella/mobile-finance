import 'package:finance/config/constanst.dart';
import 'package:finance/pages/home/widgets/balance.dart';
import 'package:finance/pages/home/widgets/transaction_container.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/metric_container.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context, listen: true);
    final appProvider = Provider.of<AppProvider>(context, listen: true);

    return Builder(
      builder: (context) {
        if (provider.wallets.isEmpty) {
          provider.getWallets(context);
        }

        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: appProvider.currentBackground,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(appName.toUpperCase()),
                    Image.asset(
                      'assets/app_icon.png',
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const NavigationBarWidget(),
            drawer: const NavigationDrawer(
              children: [
                Text("In construction. Please wait to the next version."),
              ],
            ),
            resizeToAvoidBottomInset: true, // set it to false

            body: SafeArea(
              child: Stack(
                children: [
                  FractionallySizedBox(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Container(
                        decoration:
                            BoxDecoration(color: appProvider.currentBackground),
                        child: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              // balance
                              const BalanceWidget(),
                              const TransactionContainer(),
                              MetricsContainer(
                                summaryExpenses:
                                    provider.metrics['expenses'] ?? 0,
                                summaryIncomes:
                                    provider.metrics['incomes'] ?? 0,
                                barchart: provider!.metrics?['barchart'] ?? [],
                                piechart: provider.metrics['piechart'] ?? {},
                              )
                              //  transactions
                            ]),
                          ),
                        ),
                      )),
                ],
              ),
            ));
      },
    );
  }
}
