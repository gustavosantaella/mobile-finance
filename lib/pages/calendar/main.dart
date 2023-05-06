import 'dart:async';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/helpers/fn/main.dart';
import 'package:finance/pages/home/widgets/add_movment.dart';
import 'package:finance/pages/home/widgets/list_transaction_widget.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/metric_container.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import "package:finance/services/calendar.dart";
import 'package:fl_chart/fl_chart.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<CalendarWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final PageController _pageController = PageController();
  DateTime lastDay = DateTime(9999);
  DateTime firstDay = DateTime(1);
  bool loading = false;
  List days = [];
  List _historyByDate = [];
  double summaryIncomes = 0.0;
  double summaryExpenses = 0.0;
  double incomes = 0.0;
  double expenses = 0.0;
  double total = 0.0;
  bool newDate = false;
  bool finished = false;
  late List _barChart = [];
  late Map _piechart = {};
  double _metricsExpenses = 0.0;
  double _metricsIncomes = 0.0;
  dynamic _localeCalendar;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: true);
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    historyByMonth({dynamic date, bool force = false}) async {
      try {
        // await Future.delayed(const Duration(seconds: 3));
        String walletId = walletProvider.currentWallet['info']['walletId'];
        Map response = await getHistoryByDate(walletId,
            date: date ?? DateTime.now(), field: 'month');
        List dates = response['history'].map((item) {
          var date = DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(item['createdAt']));
          return date;
        }).toList();
        List uniqueDates = [];
        dates.toList().forEach((element) {
          if (!uniqueDates.contains(element)) {
            uniqueDates.add(element);
          }
        });
        if (days.isEmpty || force) {
          print(_focusedDay);
          setState(() {
            loading = false;
            finished = true;
            incomes = response['incomes'];
            expenses = response['expenses'];
            total = response['total'];
            summaryExpenses = response['metrics']['expenses'];
            summaryIncomes = response['metrics']['incomes'];
            _barChart = response['metrics']['barchart'];
            _piechart = response['metrics']['piechart'];
            _metricsIncomes = response['metrics']['incomes'];
            _metricsExpenses = response['metrics']['expenses'];
            days = uniqueDates;
          });
        }
      } catch (e) {
        setState(() {
          loading = false;
          finished = true;
        });
        SnackBarMessage(context, Colors.red, Text(e.toString()));
      }
    }

    if (days.isEmpty &&
        newDate == false &&
        finished == false &&
        loading == false) {
      setState(() {
        loading = true;
      });
      historyByMonth(date: DateTime.now().month);
    }

    historyByDate() async {
      Map response = await getHistoryByDate(
          walletProvider.currentWallet['info']['walletId'],
          date: DateFormat('yyyy-MM-dd').format(_selectedDay),
          field: 'date');
      setState(() {
        _historyByDate = response['history'];
      });
    }

    if (window.locale.languageCode == 'es') {
      initializeDateFormatting('es_ES', null).then((value) {
        setState(() {
          _localeCalendar = 'es_ES';
        });
      });
    }

    return Scaffold(
        bottomNavigationBar: const NavigationBarWidget(),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Container(
              color: appProvider.currentBackground,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          double maxHeight = constraints.minHeight;

                          return Container(
                              margin: marginAll,
                              decoration: const BoxDecoration(
                                borderRadius: borderRadiusAll,
                                color: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  TableCalendar(
                                    locale: _localeCalendar,
                                    firstDay: firstDay,
                                    lastDay: lastDay,
                                    focusedDay: _focusedDay,
                                    calendarFormat: _calendarFormat,
                                    availableCalendarFormats: const {
                                      CalendarFormat.month: 'Month',
                                      CalendarFormat.week: 'Week',
                                    },
                                    selectedDayPredicate: (day) {
                                      // Use `selectedDayPredicate` to determine which day is currently selected.
                                      // If this s true, then `day` will be marked as selected.

                                      // Using `isSameDay` is recommended to disregard
                                      // the time-part of compared DateTime objects.
                                      return isSameDay(_selectedDay, day)
                                          ? isSameDay(_selectedDay, day)
                                          : days.contains(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(day));
                                    },
                                    onDaySelected:
                                        (selectedDay, focusedDay) async {
                                      // Call `setState()` when updating the selected day
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                      });
                                      await historyByDate();

                                      if (context.mounted) {
                                        var hist = _historyByDate
                                            .map((item) =>
                                                ListTransactionWidget(item))
                                            .toList();
                                        bottomSheetWafi(
                                            context,
                                            ListView(
                                              children: [Wrap(children: hist)],
                                            ));
                                      }
                                    },
                                    onPageChanged: (focusedDay) async {
                                      // Timer(const Duration(seconds: 1), () async {
                                        setState(() {
                                          loading = true;
                                          newDate = true;
                                          _focusedDay = focusedDay;
                                        });

                                        await historyByMonth(
                                            date: focusedDay.month,
                                            force: true);
                                        setState(() {
                                          newDate = false;
                                        });
                                        // No need to call `setState()` here
                                      // });
                                    },
                                  ),
                                  if (loading)
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: FractionallySizedBox(
                                            widthFactor: 1,
                                            heightFactor: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: borderRadiusAll,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )))
                                ],
                              ));
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: borderRadiusAll,
                            color: Colors.white,
                            boxShadow: normalShadow),
                        margin: marginAll,
                        child: Column(
                          children: [
                            donutChart(
                                summaryExpenses: _metricsExpenses,
                                summaryIncomes: _metricsIncomes),
                          ],
                        ),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: borderRadiusAll,
                            color: Colors.white,
                            boxShadow: normalShadow),
                        margin: marginAll,
                        child: Column(
                          children: [
                            piechart(data: _piechart),
                          ],
                        ),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: borderRadiusAll,
                            color: Colors.white,
                            boxShadow: normalShadow),
                        margin: marginAll,
                        padding: marginAll,
                        child: Column(
                          children: [
                            Text(lang('Dayli metric')),
                            barChart(_barChart),
                          ],
                        ),
                      )
                      // MetricsContainer(
                      //     barchart: _barChart,
                      //     piechart: _piechart,
                      //     summaryIncomes: _metricsIncomes,
                      //     summaryExpenses: _metricsExpenses)
                    ],
                  ),
                ),
              )),
        )));
  }
}
