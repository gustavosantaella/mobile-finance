import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/config/constanst.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:syncfusion_flutter_charts/charts.dart';

class MetricsContainer extends StatefulWidget {
  final double summaryExpenses;
  final double summaryIncomes;
  final Map piechart;
  final List barchart;
  const MetricsContainer(
      {this.summaryExpenses = 0.00000000000001,
      this.summaryIncomes = 0.00000000000001,
      this.piechart = const {},
      this.barchart = const [],
      super.key});

  @override
  MetricsState createState() => MetricsState();
}

class MetricsState extends State<MetricsContainer> {
  @override
  Widget build(BuildContext context) {
    Widget donutChart() {
      return Container(
        margin: const EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 1.3,
          child: fl.PieChart(fl.PieChartData(sections: [
            fl.PieChartSectionData(
                titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                value: widget.summaryIncomes,
                title:
                    "${widget.summaryIncomes < 0.000001 ? 0 : widget.summaryIncomes}%",
                color: Colors.green),
            fl.PieChartSectionData(
                titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                value: widget.summaryExpenses,
                title:
                    "${widget.summaryExpenses < 0.000001 ? 0 : widget.summaryExpenses}%",
                color: Colors.red),
          ])),
        ),
      );
    }

    Widget piechart() {
      List<Map<String, dynamic>> incomes = [];
      List<Map<String, dynamic>> expenses = [];

      if (widget.piechart.isNotEmpty) {
        widget.piechart['incomes'].forEach((e) {
          incomes.add({
            "category": e['category'],
            "value": e['value'],
          });
        });

        widget.piechart['expenses'].forEach((e) {
          expenses.add({
            "category": e['category'],
            "value": e['value'],
          });
        });
      }

      // expenses = widget.piechart['expenses'].map((e) {
      //   return {
      //     "category": e['category'],
      //     "value": e['value'],
      //   };
      // }).toList();

      // if(incomes.isEmpty){
      //   return const Text('N/A');
      // }
      return SingleChildScrollView(
        child: Row(
          // width: 200,
          children: [
            Expanded(
              child: FractionallySizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: "Expenses",
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
            const Divider(),
            Expanded(
              child: FractionallySizedBox(
                // widthFactor: .5,
                child: Column(
                  children: [
                    SizedBox(
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: "Incomes",
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
            )
          ],
        ),
      );
    }

    Widget barChar() {
      List<Map<String, dynamic>> data = widget.barchart
          .map((e) => {
                "dateName": e['dateName'],
                "income": e['income'],
                "expense": e['expense'],
              })
          .toList();

      return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          StackedColumnSeries<Map<String, dynamic>, String>(
            dataSource: data,
            xValueMapper: (Map<String, dynamic> datum, _) => datum['dateName'],
            yValueMapper: (Map<String, dynamic> datum, _) => datum['income'],
            name: 'Income',
          ),
          StackedColumnSeries<Map<String, dynamic>, String>(
            dataSource: data,
            xValueMapper: (Map<String, dynamic> datum, _) => datum['dateName'],
            yValueMapper: (Map<String, dynamic> datum, _) => datum['expense'],
            name: 'Expense',
          ),
        ],
      );
    }

    return Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: borderRadiusAll),
        margin: marginAll,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              const Text(
                "Metrics",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              CarouselSlider(
                  items: [donutChart(), barChar(), piechart()],
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    initialPage: 0,
                    enableInfiniteScroll: true,
                  ))
            ],
          ),
        ));
  }
}
