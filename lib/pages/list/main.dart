import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/history_detail.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTransactionsWidget extends StatefulWidget {
  const ListTransactionsWidget({super.key});

  @override
  ListTransactionState createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context, listen: true);

    List<Widget> typesWithMovements() {
      List<Map> dataMovements = [];
      List<Widget> data = [];

      for (int i = 0; i < walletProvider.history.length; i++) {
        int indexFound = dataMovements.indexWhere(
            (element) => element['type'] == walletProvider.history[i]['type']);
        if (indexFound.isNegative) {
          dataMovements.add({
            "type": walletProvider.history[i]['type'],
            "data": [walletProvider.history[i]]
          });
        } else {
          dataMovements[indexFound]['data']?.add(walletProvider.history[i]);
        }
      }
      printCards(List data) {
        return data.map((e) => CardWidget(e)).toList();
      }

      data = dataMovements.map((element) {
        double totalValue = 0;
        element['data']?.forEach((e) {
          totalValue += e['value'];
        });
        return Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width /
                    (dataMovements.length > 1 ? 1.5 : 1),
                decoration: const BoxDecoration(
                    borderRadius: borderRadiusAll,
                    color: Colors.white,
                    boxShadow: normalShadow),
                child: Column(children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: marginAll,
                      decoration: BoxDecoration(
                          color: Colors.black54.withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Text(
                        lang(element['type']).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 50),
                      decoration: const BoxDecoration(),
                      constraints: BoxConstraints.tightForFinite(
                          height: MediaQuery.of(context).size.height / 1.7),
                      child: FractionallySizedBox(
                        heightFactor: 1,
                        child: ListView(
                          children: [
                            ...printCards(element['data']),
                            ...printCards(element['data']),
                            ...printCards(element['data'])
                          ],
                        ),
                      )),
                ]),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: marginAll,
                decoration: BoxDecoration(
                    color: definitions['colors']['cobalto'],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                constraints: BoxConstraints.tightForFinite(
                    width: MediaQuery.of(context).size.width /
                        (dataMovements.length > 1 ? 1.5 : 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      child: Text(
                        'TOTAL',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4 ,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "\$.$totalValue",
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ))
                  ],
                ),
              )),
        ]);
      }).toList();
      return data;
    }

    return Scaffold(
      bottomNavigationBar: const NavigationBarWidget(),
      appBar: AppBar(
        title: Text(lang('Movements').toUpperCase()),
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
            margin: marginAll,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: typesWithMovements(),
                ))),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  Map data = {};
  CardWidget(this.data, {super.key});

  @override
  State<CardWidget> createState() => CardState();
}

class CardState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          bottomSheetWafi(context, HistoryDetail(widget.data['_id']));
        },
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: normalShadow),
          padding: marginAll,
          margin:
              const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [Text(widget.data['historyId'])],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.data['categoryName'],
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      "${widget.data['value']}",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ])
            ],
          ),
        ));
  }
}
