
import 'package:finance/pages/home/widgets/balance.dart';
import 'package:finance/pages/home/widgets/list_transaction_widget.dart';
import 'package:finance/pages/home/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
    const HomePage({super.key});

  @override 
  HomeState createState() => HomeState();
}
class HomeState extends State<HomePage> {
  static int balance = 0;


  void setBalance(int value){
    setState(() {
      balance = value;
    });
  }

  List<Widget> _sd() {
    List<Widget> array = [];

    for (int i = 0; i < 10; i++) {
      array.add(ListTransactionWidget(i: i));
    }
    return array;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          FractionallySizedBox(
              heightFactor: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(children: [
                  //   nav
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                style: const ButtonStyle(),
                                onPressed: () =>
                                    print(MediaQuery.of(context).size.height),
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
                                          fontSize: 20, color: Colors.white),
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
                    children:  [
                      IconButton(onPressed:  () => {
                        showDialog(context: context, builder: (BuildContext contex) {
                           return const AlertDialog(
                            content: Text("asdasd"),
                           );
                        })
                      }, icon: const Icon(Icons.search_sharp, color: Colors.white,))
                    ],
                  ),
                  //  transactions
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(100, 100, 100, .5),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: _sd(),
                      ),
                    ),
                  )
                ]),
              )),
              BottomSheetWiget()       
        ],
      ),
    ));
  }
}

