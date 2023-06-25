import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:flutter/material.dart';
import 'package:wafi/services/home.dart' as service;
import 'package:wafi/providers/wallet_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wafi/widgets/categories_widget.dart';

Logger logger = Logger();

class AddMovementWidget extends StatefulWidget {
  const AddMovementWidget({Key? key}) : super(key: key);

  @override
  State<AddMovementWidget> createState() => _AddMovementState();
}

class _AddMovementState extends State<AddMovementWidget> {
  static bool isExpense = false;
  bool loading = false;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  late Future<List> categories;
  Map categorySelected = {};

  Future<List> getCategories() async {
    try {
      final data = await service.getCategoriest();
      return data;
    } catch (e) {
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
    final provider = Provider.of<WalletProvider>(context, listen: true);
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
                            child: Text(
                              lang("ADD MOVEMENT"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value == '0' ||
                                      value.isEmpty) {
                                    return 'can not be 0';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: amountController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.attach_money),
                                  border: outlineInputBorder,
                                  labelText: lang('Amount'),
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
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    prefixIcon: const Icon(Icons.description),
                                    labelText: lang('Description'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: CategoriesWidget((e) {
                              setState(() {
                                categorySelected = e as Map;
                              });
                            }, categorySelected['label'] ?? ""))
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
                            style: ButtonStyle(
                                backgroundColor: loading == true
                                    ? const MaterialStatePropertyAll(
                                        Colors.grey)
                                    : null),
                            onPressed: loading == true
                                ? null
                                : () async {

                                    try {
                                      setState(() {
                                        loading = true;
                                      });
                                      bool validation = _formKey.currentState
                                          ?.validate() as bool;
                                      if (validation == false ||
                                          categorySelected.isEmpty) {
                                        setState(() {
                                          loading = false;
                                        });
                                        return;
                                      }

                                      provider.loadingWallet = true;
                                      await service.addTohistory(
                                          amountController.text,
                                          descriptionController.text,
                                          categorySelected['id'],
                                          isExpense,
                                          provider.currentWallet['info']
                                              ['_id']);
                                      if (context.mounted) {
                                        setState(() {
                                          loading = false;
                                        });
                                        provider.getBalance(
                                            provider.currentWallet['info']
                                                ['_id'],
                                            context);
                                        provider.setRefreshHistory(
                                            provider.currentWallet['info']
                                                ['_id'],
                                            context);
                                        Navigator.pop(context);
                                      }
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                        logger.e(e.toString());
                                      });
                                    }
                                  },
                            child: Text(lang('Submit')))
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
