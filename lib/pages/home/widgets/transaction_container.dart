import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/bottom_sheets.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/pages/home/widgets/add_movment.dart';
import 'package:finance/pages/home/widgets/list_transaction_widget.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({super.key});

  List<Widget> listTransactios(List data) {
    List<Widget> array = [];
    for (int i = 0; i < data.length; i++) {
      array.add(ListTransactionWidget(data[i], i: i));
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: true);

    return Container(
      margin: marginAll,
      decoration: const BoxDecoration(
          boxShadow: normalShadow,
          color: Colors.white,
          borderRadius: borderRadiusAll),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        // alignment: AlignmentDirectional.bottomStart,
        children: [
          SizedBox(
            height: double.maxFinite,
            child: ListView(
              children:
                  listTransactios(walletProvider.history.reversed.toList()),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: definitions['colors']['cobalto'],
                      borderRadius: borderRadiusAll),
                  height: 100,
                  child: Center(
                      child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          lang('New movement'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(10)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 10, 179, 208))),
                            onPressed: () {
                              bottomSheetWafi(
                                  context,
                                  const Scaffold(
                                    persistentFooterAlignment:AlignmentDirectional.topEnd,
                                    body: AddMovementWidget(),
                                  )
                                 );
                            },
                            child: Text(
                              lang('add'),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  )),
                ),
              )),
        ],
      ),
    );
  
  }
}
