import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/pages/home/widgets/balance.dart';
import 'package:finance/pages/home/widgets/transaction_container.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/metric_container.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

    Widget piechart() {
      List<Map<String, dynamic>> incomes = [];
      List<Map<String, dynamic>> expenses = [];

      if (provider.metrics['piechart'] != null &&
          provider.metrics['piechart']?.isNotEmpty) {
        provider.metrics['piechart']['incomes'].forEach((e) {
          incomes.add({
            "category": e['category'],
            "value": e['value'],
          });
        });

        provider.metrics['piechart']['expenses'].forEach((e) {
          expenses.add({
            "category": e['category'],
            "value": e['value'],
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

    return Builder(
      builder: (context) {


        return Scaffold(
            bottomNavigationBar: const NavigationBarWidget(),
            drawer: const NavigationDrawer(
              children: [
                Text("In construction. Please wait to the next version."),
              ],
            ),
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
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 30, left: 30, right: 30, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:  [
                                        Text(
                                          '${lang("hi")}!',
                                          style: const TextStyle(
                                              fontSize: 26, color: Colors.grey),
                                        ),
                                        Text(
                                          lang('Welcome back'),
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  43, 28, 26, 26)),
                                          color: const Color.fromARGB(
                                              86, 158, 158, 158),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100))),
                                      child: IconButton(
                                          // icon
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            Navigator.popAndPushNamed(context, '/profile');
                                          },
                                          icon: const Icon(
                                            Icons.person,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              // balance
                              const BalanceWidget(),
                              piechart(),
                              const TransactionContainer(),
                              // MetricsContainer(
                              //   summaryExpenses:
                              //       provider.metrics['expenses'] ?? 0,
                              //   summaryIncomes:
                              //       provider.metrics['incomes'] ?? 0,
                              //   barchart: provider!.metrics?['barchart'] ?? [],
                              //   piechart: provider.metrics['piechart'] ?? {},
                              // )
                              //  transactions
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
