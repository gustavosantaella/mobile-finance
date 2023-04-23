import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/pages/home/widgets/add_movment.dart';
import 'package:finance/pages/home/widgets/balance.dart';
import 'package:finance/pages/home/widgets/list_transaction_widget.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance/config/constanst.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
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
    final appProvider = Provider.of<AppProvider>(context, listen: true);

    return Consumer<WalletProvider>(
      builder: <WalletProvider>(context, value, child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: appProvider.currentBackground,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const NavigationBarWidget(),
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
                        decoration:
                            BoxDecoration(color: appProvider.currentBackground),
                        child: Column(children: [
                          // balance
                          const BalanceWidget(),

                          //  transactions
                          Expanded(
                            // flex: 1,
                            child: FractionallySizedBox(
                                widthFactor: 1,
                                // heightFactor: 1,
                                child: Container(
                                  // height: MediaQuery.of(context).size.height,
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.358),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Builder(builder: (context) {
                                    if (provider.loadingHistory == true) {
                                      return const Center(
                                        child: FractionallySizedBox(
                                          widthFactor: 0.1,
                                          heightFactor: 0.1,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    if (provider.loadingHistory == false &&
                                        provider.history.isEmpty) {
                                      return FractionallySizedBox(
                                          heightFactor: 0.5,
                                          widthFactor: 1,
                                          child: Center(
                                            widthFactor: 1,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text(
                                                  'Add new movement',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Icon(Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ));
                                    }

                                    return ListView(
                                      children: listTransactios(
                                          provider.history!.reversed.toList()),
                                    );
                                  }),
                                )),
                          )
                        ]),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: const BoxDecoration(),
                        child: IconButton(
                            onPressed: () => bottomSheetWafi(
                                context, const AddMovementWidget()),
                            icon: const Icon(
                              Icons.add_circle_rounded,
                              size: 60,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
