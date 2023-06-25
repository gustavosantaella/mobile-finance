import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/providers/wallet_provider.dart';
import 'package:wafi/services/loan.dart';
import 'package:wafi/widgets/categories_widget.dart';
import 'package:wafi/widgets/fn.dart';
import 'package:wafi/widgets/snack_bar.dart';

class NewLoanWidget extends StatefulWidget {
  final bool isLoan;
  final dynamic setStateCallbackLoans;
  const NewLoanWidget(this.isLoan, {super.key, this.setStateCallbackLoans});
  @override
  NewLoandState createState() => NewLoandState();
}

class NewLoandState extends State<NewLoanWidget> {
  Map categorySelected = {};
  String walletPk = "";
  bool isLoading = false;

  final TextEditingController _amount = TextEditingController();
  final TextEditingController _who = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context);
    return Builder(builder: (context) {
      return Container(
        margin: marginAll,
        child: FormField(builder: (formContext) {
          return Wrap(
            runSpacing: 10,
            children: [
              TextFormField(
                controller: _who,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderRadius: borderRadiusAll),
                    label: Text(lang("Who?"))),
              ),
              TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description),
                      border: const OutlineInputBorder(
                          borderRadius: borderRadiusAll),
                      label: Text(lang("Description")))),
              CategoriesWidget((e) {
                setState(() {
                  categorySelected = e;
                });
              }, categorySelected['label'] ?? ""),
              TextFormField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.money),
                    border: outlineInputBorder,
                    label: Text(lang("Amount"))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang("Select a walle to assign Loan"),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  dropdownWalletCurrencies(walletProvider.wallets, null,
                      (value) {
                    setState(() {
                      walletPk = value['_id'];
                    });
                  }),
                  ElevatedButton(
                      onPressed: isLoading == true
                          ? null
                          : () async {
                              Map payload = {
                                "walletPk": walletPk,
                                "categoryPk": categorySelected["id"],
                                "amount": _amount.text,
                                "isLoan": widget.isLoan,
                                "description": _description.text,
                                "who": _who.text,
                              };
                              try {
                                Map data = await newLoan(payload);
                                if (widget.setStateCallbackLoans != null) {
                                  widget.setStateCallbackLoans(data);
                                }
                                if(widget.isLoan == true && context.mounted){
                                   walletProvider.setRefreshHistory(walletPk, context);
                                }
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                               
                                Navigator.pop(context);
                                SnackBarMessage(context, e.toString());
                              }
                            },
                      child: Text(lang('Submit')))
                ],
              ),
            ],
          );
        }),
      );
    });
  }
}
