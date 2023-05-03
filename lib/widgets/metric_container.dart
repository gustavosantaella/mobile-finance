import 'package:finance/helpers/fn/lang.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

Widget donutChart({double summaryExpenses = 0.0, double summaryIncomes = 0.0}) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings: ConnectorLineSettings(
              type: ConnectorType.curve,
            ),
          ),
          dataSource: <ChartData>[
            ChartData(lang('incomes'), summaryIncomes),
            ChartData(lang('expenses'), summaryExpenses),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      ],
    ),
  );
}

Widget piechart({data}) {
  List<Map<String, dynamic>> incomes = [];
  List<Map<String, dynamic>> expenses = [];

  if (data?.isNotEmpty) {
    data['incomes'].forEach((e) {
      incomes.add({
        "category": e['category'],
        "value": e['value'],
      });
    });

    data['expenses'].forEach((e) {
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
        const Divider(),
        Expanded(
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
        )
      ],
    ),
  );
}

Widget barChart(List data_list) {
  List<Map<String, dynamic>> data = data_list
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
