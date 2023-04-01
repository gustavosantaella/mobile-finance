import 'package:finance/pages/home/services/service.dart' as service;
import 'package:flutter/material.dart';

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
                  constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.of(context).size.height.floorToDouble() /
                              2),
                  isScrollControlled: true,
                  isDismissible: true,
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

  @override
  void initState() {
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.attach_money),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_money),
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: amountController,
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
                                  color:
                                      const Color.fromRGBO(100, 100, 100, .7)),
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
                                    value: item,
                                    child: SizedBox(
                                      width: 200,
                                      child: Text(item.toString()),
                                    ),
                                  ));
                                });
                                return DropdownButton(
                                    items: items,
                                    isDense: true,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(10),
                                    hint: Text(categorySelected),
                                    onChanged: (obj) {
                                      print(obj);
                                      setState(() {
                                        categorySelected = obj.toString();
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
                    Switch(value: isExpense, onChanged: (bool value) {}),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      amountController.text = 99834.toString();
                      print(amountController.text);
                    },
                    child: const Text("Send"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
