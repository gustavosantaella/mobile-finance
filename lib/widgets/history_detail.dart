import 'dart:convert';

import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/services/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryDetail extends StatefulWidget {
  String id = '';
  HistoryDetail(this.id, {super.key});

  @override
  HistoryDetailState createState() => HistoryDetailState();
}

class HistoryDetailState extends State<HistoryDetail> {
  bool loading = false;
  Map data = {};
  bool error = false;

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of<WalletProvider>(context);
    if (loading == false && widget.id.isNotEmpty && data.isEmpty  && error == false) {
      setState(() {
        loading = true;
      });
      historyDetail(widget.id, walletProvider.currentWallet['info']['walletId'])
          .then((value) {
        data = value;
      }).catchError((e) {
        print(e);
        setState(() {
          error = true;
        });
        //  SnackBarMessage(context, Colors.red, Text(e.toString()));
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
        print('completed');
      });
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: !loading
          ? Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Colors.black,
                          size: 20,
                        )),
                    Text(
                      "#${data['historyId']}",
                      style: const TextStyle(
                          fontSize: 20, color: Color.fromARGB(164, 57, 57, 57)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(lang("Amount"), style: const TextStyle(fontSize: 17)),
                    Text(
                      "\$.${data['value']}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(lang("Type"), style: const TextStyle(fontSize: 17)),
                    Text(
                      "${lang(data['type'])}",
                      style: TextStyle(
                          fontSize: 20,
                          color: data['type'] == 'expense'
                              ? Colors.red
                              : Colors.green),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(lang("Provider"), style: const TextStyle(fontSize: 17)),
                    Text(
                      "${data['gateway']['provider']}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(lang("Category"), style: const TextStyle(fontSize: 17)),
                    Text(
                      "${data['categories']['name']}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          : Text(loading ? 'loading' : 'ready'),
    );
  }
}
