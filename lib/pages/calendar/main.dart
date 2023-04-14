import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/pages/home/widgets/add_movment.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import "package:finance/services/calendar.dart";

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: true);
    historyByMonth({dynamic focusedDay}) async {
      try {
        await Future.delayed(const Duration(seconds: 3));
        String walletId = walletProvider.currentWallet['info']['walletId'];
        List response = await getHistoryByDate(walletId, focusedDay ?? _selectedDay);
        List dates = response.map((item){
          var date = DateFormat("yyyy-MM-dd").format(DateTime.parse(item['createdAt']));
          return date;
        }).toList(); 
        List dates = [];
      } catch (e) {
        SnackBarMessage(context, Colors.red, Text(e.toString()));
      }
    }

    return Scaffold(
        bottomNavigationBar: const NavigationBarWidget(),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: PageView(
                          controller: _pageController,
                          children: [
                            FutureBuilder(
                              future: historyByMonth(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return TableCalendar(
                                    shouldFillViewport: true,
                                    firstDay: firstDay,
                                    lastDay: lastDay,
                                    focusedDay: _focusedDay,
                                    calendarFormat: _calendarFormat,
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
                                    onDaySelected: (selectedDay, focusedDay) {
                                      // Call `setState()` when updating the selected day
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                      });
                                      bottomSheetWafi(
                                          context, const AddMovementWidget());
                                    },
                                    onPageChanged: (focusedDay) async {
                                      await historyByMonth(focusedDay: focusedDay);
                                      // No need to call `setState()` here
                                      _focusedDay = focusedDay;
                                    },
                                  );
                                } else {
                                  return const Text("Loading");
                                }
                              },
                            )
                          ],
                        ))))));
  }
}
