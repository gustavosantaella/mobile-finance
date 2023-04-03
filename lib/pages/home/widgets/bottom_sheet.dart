import 'dart:math';

import 'package:finance/pages/home/services/service.dart' as service;
import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetWiget extends StatelessWidget {
  const BottomSheetWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(),
          child: IconButton(
              onPressed: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const AddMovementWidget();
                  },
                );

                print(22323423);
              },
              icon: const Icon(
                Icons.add_circle_rounded,
                size: 60,
                color: Colors.blue,
              )),
        ),
      ),
    );
  }
}

class AddMovementWidget extends StatefulWidget {
  const AddMovementWidget({Key? key}) : super(key: key);

  @override
  State<AddMovementWidget> createState() => _AddMovementState();
}

class _AddMovementState extends State<AddMovementWidget> {
  static bool isExpense = false;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  late Future<List> categories;
  String categorySelected = '';

  Future<List> getCategories() async {
    try {
      final data = await service.getCategoriest();
      return data;
    } catch (e) {
      print('error');
      print(e.toString());
      return [];
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext ctx;
    final provider = Provider.of<WalletProvider>(context);
    return Container(
        // height: MediaQuery.of(context).size.height  <= 700 == true ? MediaQuery.of(context).size.height /2.2 : MediaQuery.of(context).size.height /4,
        margin: const EdgeInsets.all(10),
        child: Wrap(children: [
          Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              "ADD MOVEMENT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_money),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value == '0' ||
                                      value.isEmpty) {
                                    return 'Can';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: amountController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Amount',
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.description),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Description',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.category),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              100, 100, 100, .7)),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: DropdownButtonHideUnderline(
                                    child: FutureBuilder(
                                      future: categories,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Container();
                                        }

                                        List<DropdownMenuItem> items = [];
                                        snapshot.data?.forEach((item) {
                                          items.add(DropdownMenuItem(
                                            value: item?['id'],
                                            child: SizedBox(
                                              width: 200,
                                              child: Text(
                                                  item['label'].toString()),
                                            ),
                                          ));
                                        });
                                        return DropdownButton(
                                            items: items,
                                            isDense: true,
                                            isExpanded: true,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            hint: Text(categorySelected),
                                            onChanged: (categoryId) {
                                              setState(() {
                                                categorySelected = categoryId;
                                              });
                                            });
                                      },
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.arrow_drop_up, color: Colors.green),
                                Icon(Icons.arrow_drop_down, color: Colors.red),
                              ],
                            ),
                            Switch(
                                value: isExpense,
                                onChanged: (bool value) {
                                  setState(() {
                                    isExpense = value;
                                  });
                                }),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              bool validation =
                                  _formKey.currentState?.validate() as bool;
                              if (validation == false) {
                                return;
                              }

                              await service.addTohistory(
                                  amountController.text,
                                  descriptionController.text,
                                  categorySelected,
                                  isExpense);
                              // TODO: remove hard-code
                              provider.setRefreshHistory(
                                  "6428550c474acb036e24f579");
                              print('ready');
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Send"))
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ]));
  }
}
