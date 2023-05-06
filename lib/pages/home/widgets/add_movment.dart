import 'package:finance/helpers/fn/lang.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/home.dart' as service;
import 'package:finance/providers/wallet_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

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
  String categorySelected = '';

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
                            child:  Text(
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
                            const Icon(Icons.attach_money),
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
                                decoration:  InputDecoration(
                                  border:const OutlineInputBorder(),
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
                              const Icon(Icons.description),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: descriptionController,
                                  decoration:  InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: lang('Description'),
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
                                        if (snapshot.hasError || snapshot.connectionState != ConnectionState.done) {
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
                                        var indexName = snapshot.data?.indexWhere((element) => element['id'] == categorySelected );
                                        String name = lang('Category');
                                        if(indexName != null &&  !indexName.isNegative){
                                            name = snapshot.data?[indexName]?['label'];
                                        }
                                        return DropdownButton(
                                            items: items,
                                            isDense: true,
                                            isExpanded: true,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            hint: Text(name),
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
                          style: ButtonStyle(
                            backgroundColor: loading == true ? const MaterialStatePropertyAll(Colors.grey) : null
                          ),
                            onPressed:loading == true ? null : () async {
                              try{
                                setState(() {
                                loading = true;
                              });
                              bool validation =
                                  _formKey.currentState?.validate() as bool;
                              if (validation == false || categorySelected.isEmpty) {
                                setState(() {
                                  loading = false;
                                });
                                return;
                              }
                          
                              provider.loadingWallet = true;
                              await service.addTohistory(
                                  amountController.text,
                                  descriptionController.text,
                                  categorySelected,
                                  isExpense,
                                  provider.currentWallet['info']['walletId']);

                              provider.notifyListeners();
                              if (context.mounted) {
                                setState(() {
                                  loading = false;
                                });
                                provider.getBalance(
                                    provider.currentWallet['info']['walletId'],
                                    context);
                                provider.setRefreshHistory(
                                    provider.currentWallet['info']['walletId'],
                                    context);
                                Navigator.pop(context);
                              }
                              }catch(e){
                                setState(() {
                                  loading = false;
                                  logger.e(e.toString());
                                });
                              }
                            },
                            child:  Text(lang('Submit')))
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
