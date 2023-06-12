import 'dart:async';
import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/services/schedule.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:finance/services/home.dart' as service;

Logger logger = Logger();

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  ScheduleStateWidget createState() => ScheduleStateWidget();
}

class ScheduleStateWidget extends State<ScheduleWidget> {
  late List schedules = [];
  late dynamic error = false;

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of<WalletProvider>(context);

    getSchedulesByWallet() async {
      List responseSchedules = await getSchedules(
          context, walletProvider.currentWallet["info"]["_id"]);
      setState(() {
        schedules = responseSchedules;
      });
    }

    if (schedules.isEmpty) {
      getSchedulesByWallet();
    }

    removeSchedule(schedulePk) async {
      await deleteSchedule(context, schedulePk);
      await getSchedulesByWallet();
    }

    return Scaffold(
        appBar: AppBar(title: Text(lang("Schedules"))),
        bottomNavigationBar: const NavigationBarWidget(),
        body: FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: Stack(
              // alignment: AlignmentDirectional.bottomEnd,
              children: [
                scheduleCards(this, context: context, removeSchedule),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: FloatingActionButton(
                      tooltip: "hola",
                      child: const Text(
                        "+",
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: () {
                        // add here
                        bottomSheetWafi(
                            context,  AddOrEditScheduleWidget(getSchedulesByWallet));
                      }),
                ),
              ],
            )));
  }
}

Widget scheduleCards(ScheduleStateWidget widget, Function removeSchedule,
    {required BuildContext context}) {
  return SingleChildScrollView(
    child: Wrap(
        children: widget.schedules.map((e) {
      return GestureDetector(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: borderRadiusAll,
                color: Colors.white,
                boxShadow: normalShadow),
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () async {
                          List<Future> futures = [removeSchedule(e['_id'])];

                          await Future.wait(futures);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.punch_clock_sharp),
                          Text(lang(e['periodicity']))
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.punch_clock_sharp),
                          Text("${lang("Next date")}: ${e['nextDate']}")
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("${lang("Amount")}: \$.${e['amount']}"),
                const SizedBox(
                  height: 5,
                ),
                Text("${lang("Type")}: ${lang(e['type'])}"),
              ],
            )),
      );
    }).toList()),
  );
}

class AddOrEditScheduleWidget extends StatefulWidget {
  final Function getSchedules;
  const AddOrEditScheduleWidget(this.getSchedules, {super.key});

  @override
  AddOrEditScheduleState createState() => AddOrEditScheduleState();
}

class AddOrEditScheduleState extends State<AddOrEditScheduleWidget> {
  List<dynamic> scheduleTypes = definitions['schedules']['finances'];

  late Map data = {
    "name": null,
    "amount": null,
    "categoryId": '',
    "type": null,
    "periodicity": scheduleTypes[0],
  };

  bool loading = false;
  List categories = [];

  void setData(String value, String field) {
    setState(() {
      data[field] = value;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  getCategories() async {
    List ct = await service.getCategoriest();
    setState(() {
      categories = ct;
    });
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context);
    if (categories.isEmpty && context.mounted) {
      getCategories();
    }
    return Builder(builder: (context) {
      List<dynamic> typekeys = definitions['history']['type'].keys.toList();
      List<DropdownMenuItem> items = scheduleTypes
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(lang(e)),
              ))
          .toList();

      TextEditingController amountController =
          TextEditingController(text: data['amount']);
      TextEditingController scheduleNameController =
          TextEditingController(text: data['name']);

      return Container(
          margin: const EdgeInsets.all(10),
          child: Wrap(
            children: [
              TextField(
                onChanged: (value) {
                  setData(value, 'name');
                },
                decoration: InputDecoration(label: Text(lang("Schedule name"))),
              ),
              TextField(
                onChanged: (value) {
                  setData(value, 'amount');
                },
                decoration: InputDecoration(label: Text(lang("Amount"))),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: DropdownButton(
                    isExpanded: true,
                    value: data['periodicity'] ?? scheduleTypes[0],
                    items: items,
                    onChanged: (value) {
                      setData(value, 'periodicity');
                    }),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(100, 100, 100, .7)),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButtonHideUnderline(
                    child: FutureBuilder(
                      future: Future.value(categories),
                      builder: (context, snapshot) {
                        if (snapshot.hasError ||
                            snapshot.connectionState != ConnectionState.done) {
                          return Container();
                        }

                        List<DropdownMenuItem> items = [];
                        snapshot.data?.forEach((item) {
                          items.add(DropdownMenuItem(
                            value: item?['id'],
                            child: SizedBox(
                              width: 200,
                              child: Text(item['label'].toString()),
                            ),
                          ));
                        });
                        var indexName = snapshot.data?.indexWhere(
                            (element) => element['id'] == data['categoryId']);
                        String name = lang('Category');
                        if (indexName != null && !indexName.isNegative) {
                          name = snapshot.data?[indexName]?['label'];
                        }
                        return DropdownButton(
                            items: items,
                            isDense: true,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            hint: Text(name),
                            onChanged: (categoryId) {
                              setData(categoryId, 'categoryId');
                            });
                      },
                    ),
                  )),
              Wrap(
                  direction: Axis.horizontal,
                  children: typekeys.map((e) {
                    return Row(
                      children: [
                        Radio(
                            value: e,
                            groupValue: data['type'],
                            onChanged: (value) {
                              setData(value, 'type');
                            }),
                        Text(lang(e))
                      ],
                    );
                  }).toList()),
              Row(
                children: [
                  TextButton(
                      onPressed: loading == true
                          ? null
                          : () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                data = {
                                  ...data,
                                  "amount": amountController.text,
                                  "name": scheduleNameController.text
                                };
                                data.forEach((key, value) {
                                  if (value == null) {
                                    throw Exception("$key cant't be empty");
                                  }
                                  if (value?.trim() == '') {
                                    throw Exception("$key cant't be empty");
                                  }
                                });
                                logger.d(data);
                                List<Future> futures = [
                                  add(context, {
                                    ...data,
                                    "walletId": walletProvider
                                        .currentWallet['info']["_id"]
                                  }),
                                  widget.getSchedules()
                                ];
                                await Future.wait(futures);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                SnackBarMessage(
                                    context, Colors.red, Text(e.toString()));
                              } finally {
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                      child: Text(lang("Submit"))),
                ],
              )
            ],
          ));
    });
    ;
  }
}
