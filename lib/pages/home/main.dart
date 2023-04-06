import 'package:finance/pages/home/widgets/balance.dart';
import 'package:finance/pages/home/widgets/list_transaction_widget.dart';
import 'package:finance/pages/home/widgets/bottom_sheet.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance/config/constanst.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  static int balance = 0;

  void setBalance(int value) {
    setState(() {
      balance = value;
    });
  }

  List<Widget> listTransactios(List data) {
    List<Widget> array = [];
    for (int i = 0; i < data.length; i++) {
      array.add(ListTransactionWidget(data[i], i: i));
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context, listen: true);
    return Scaffold(
        drawer: const NavigationDrawer(
          children: [
            Text("In construction. Please wait to the next version."),
          ],
        ),
        resizeToAvoidBottomInset: true, // set it to false

        body: SafeArea(
          child: Stack(
            children: [
              FractionallySizedBox(
                  heightFactor: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: definitions['colors']['background']['blue']),
                    child: Column(children: [
                      //   nav
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    style: const ButtonStyle(),
                                    onPressed: () => print(
                                        MediaQuery.of(context).size.height),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(
                                          Icons.person_2_rounded,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Welcome, Gustavo Alejandro",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                                const Icon(
                                  Icons.settings,
                                  size: 30,
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                      // balance
                      BalanceWidget(setBalance, balance),
                      //  filters
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext contex) {
                                          return AlertDialog(
                                            content: Consumer<WalletProvider>(
                                                builder:
                                                    (context, value, child) =>
                                                        Text("asd".toString())),
                                          );
                                        })
                                  },
                              icon: const Icon(
                                Icons.search_sharp,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      //  transactions
                      Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Container(
                                height: MediaQuery.of(context).size.height,
                                margin: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(100, 100, 100, .5),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                  color: Colors.white,
                                ),
                                child: Consumer<WalletProvider>(
                                  builder: (context, value, child) {
                                    return FutureBuilder(
                                      // TODO: remove hard-code
                                      future: value.getHistroy(
                                          "6428550c474acb036e24f579"),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              "an error ocurred to get history");
                                        } else if (snapshot.hasData) {
                                          return ListView(
                                            children: listTransactios(snapshot
                                                .data!.reversed
                                                .toList()),
                                          );
                                        } else {
                                          return const Center(
                                            child: FractionallySizedBox(
                                              widthFactor: 0.3,
                                              heightFactor: 0.3,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                )),
                          ))
                    ]),
                  )),
              const BottomSheetWiget()
            ],
          ),
        ));
  }
}
