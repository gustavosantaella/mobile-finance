import 'package:finance/helpers/fn/lang.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
final Logger logger  = Logger();
Widget donutChart(
    {String summaryExpenses = '0.0', String summaryIncomes = '0.0'}) {
  try {
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
              ChartData(lang('incomes'), double.parse(summaryIncomes)),
              ChartData(lang('expenses'), double.parse(summaryExpenses)),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ),
    );
  } catch (e) {
    logger.e('error here 3');
    return Container();
  }
}

Widget piechart({data}) {
  try {
    List<Map<String, dynamic>> incomes = [];
    List<Map<String, dynamic>> expenses = [];

    if (data?.isNotEmpty) {
      data['incomes'].forEach((e) {
        incomes.add({
          "category": e['category'],
          "value": double.parse(e['value'] ?? '0'),
        });
      });

      data['expenses'].forEach((e) {
        expenses.add({
          "category": e['category'],
          "value": double.parse(e['value'] ?? '0'),
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
  } catch (e) {
    logger.e('errro here 2');
    return Container();
  }
}

Widget barChart(List dataList) {
  try {
    List<Map<String, dynamic>> data = dataList
        .map((e) => {
              "dateName": e['dateName'],
              "income": e['income'] ?? '0',
              "expense": e['expense'] ?? '0',
            })
        .toList();

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        StackedColumnSeries<Map<String, dynamic>, String>(
          dataSource: data,
          xValueMapper: (Map<String, dynamic> datum, _) => datum['dateName'],
          yValueMapper: (Map<String, dynamic> datum, _) =>
              double.parse(datum['income'] ?? '0'),
          name: 'Income',
        ),
        StackedColumnSeries<Map<String, dynamic>, String>(
          dataSource: data,
          xValueMapper: (Map<String, dynamic> datum, _) => datum['dateName'],
          yValueMapper: (Map<String, dynamic> datum, _) =>
              double.parse(datum['expense'] ?? '0'),
          name: 'Expense',
        ),
      ],
    );
  } catch (e) {
    logger.e("error aqui 2");
    return Container();
  }
}
