import 'package:admob_flutter/admob_flutter.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/pages/home/widgets/balance.dart';
import 'package:wafi/pages/home/widgets/transaction_container.dart';
import 'package:wafi/providers/app_provider.dart';
import 'package:wafi/providers/drawe_provider.dart';
import 'package:wafi/providers/wallet_provider.dart';
import 'package:wafi/services/auth.dart';
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wafi/widgets/snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WalletProvider walletProvider = Provider.of(context, listen: false);
      walletProvider.setRefreshHistory(
          walletProvider.currentWallet['info']['_id'], context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context, listen: true);
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);

    Widget piechart() {
      List<Map<String, dynamic>> incomes = [];
      List<Map<String, dynamic>> expenses = [];

      if (provider.metrics['piechart'] != null &&
          provider.metrics['piechart']?.isNotEmpty) {
        provider.metrics['piechart']['incomes'].forEach((e) {
          incomes.add({
            "category": e['category'],
            "value": double.parse(e?['value'] ?? '0'),
          });
        });

        provider.metrics['piechart']['expenses'].forEach((e) {
          expenses.add({
            "category": e['category'],
            "value": double.parse(e?['value'] ?? '0'),
          });
        });
      }
      List<Widget> rows = [];
      if (incomes.isNotEmpty) {
        rows.add(Expanded(
          child: FractionallySizedBox(
            // widthFactor: .5,
            child: Column(
              children: [
                SizedBox(
                  child: SfCircularChart(
                    title: ChartTitle(
                      text: lang('incomes'),
                      textStyle: const TextStyle(color: Colors.green),
                    ),
                    legend: Legend(
                      isVisible: true,
                      height: '10%',
                      width: '100%%',
                      orientation: LegendItemOrientation.vertical,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.bottom,
                    ),
                    series: <CircularSeries>[
                      PieSeries<Map<String, dynamic>, String>(
                        dataSource: incomes,
                        xValueMapper: (Map<String, dynamic> datum, _) =>
                            datum['category'],
                        yValueMapper: (Map<String, dynamic> datum, _) =>
                            datum['value'],
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }

      if (expenses.isNotEmpty) {
        rows.add(const Divider());
        rows.add(
          Expanded(
            child: FractionallySizedBox(
              child: Column(
                children: [
                  SizedBox(
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: lang('expenses'),
                        textStyle: const TextStyle(color: Colors.red),
                      ),
                      legend: Legend(
                        isVisible: true,
                        height: '10%',
                        width: '100%%',
                        orientation: LegendItemOrientation.vertical,
                        overflowMode: LegendItemOverflowMode.wrap,
                        position: LegendPosition.bottom,
                      ),
                      series: <CircularSeries>[
                        PieSeries<Map<String, dynamic>, String>(
                          dataSource: expenses,
                          xValueMapper: (Map<String, dynamic> datum, _) =>
                              datum['category'],
                          yValueMapper: (Map<String, dynamic> datum, _) =>
                              datum['value'],
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Row(
          // width: 200,
          children: rows,
        ),
      );
    }

    drawerProvider.children = [
      TextButton(onPressed: () {}, child: Text(lang("Conversions"))),
      TextButton(onPressed: () {}, child: Text(lang("New Wallet"))),
    ];
    return Builder(
      builder: (context) {
        return Scaffold(
            extendBody: true,
            key: _scaffoldKey,
            appBar: appBarWidget(context, lang("Hi!"),
                subTitle: lang("Welcome back"), key: _scaffoldKey),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   foregroundColor: Colors.red,
            //   splashColor: Colors.red,
            //   backgroundColor: Colors.white,
            //   hoverColor: Colors.yellow,
            //   child: const Icon(Icons.home),
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const NavigationBarWidget(),
            drawer: mainDrawer(context),
            resizeToAvoidBottomInset: true, // set it to false

            body: SafeArea(
                child: SizedBox(
              // margin: const EdgeInsets.only(top: 10),
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
                                AdmobBanner(
                                  adSize: AdmobBannerSize.LARGE_BANNER,
                                  adUnitId: ads['banner1'] as String,
                                ),
                              // balance
                              const BalanceWidget(),
                              piechart(),
                              const TransactionContainer(),
                            ]),
                          ),
                        ),
                      )),
                ],
              ),
            )));
      },
    );
  }
}
