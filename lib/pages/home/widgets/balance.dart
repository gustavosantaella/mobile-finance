import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceWidget extends StatelessWidget {
  int balance = 0;
  Function(int value) setBalance;

  BalanceWidget(this.setBalance, this.balance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvicer = Provider.of<WalletProvider>(context);
    return Consumer(
        builder: (context, value, child) => Row(
              children: [
                Expanded(
                    child: Container(
                  // height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(100, 100, 100, .2),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: walletProvicer.walletS == null ? [] : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network('https://flagsapi.com/VE/shiny/64.png',
                              scale: 1.5,
                              errorBuilder: (context, error, stackTrace) {
                            return const Text("Some error");
                          }, loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return const Text('hola');
                            }
                            return child;
                          }),
                          IconButton(
                            onPressed: () {
                              print(2);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        'Balance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w200),
                      ),
                      Text(
                        balance.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Incomes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '\$.1250',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Growth rate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '1250%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: 1 <= 0 ? Colors.red : Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Expenses',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '\$.1250',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.red),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ));
  }
}
