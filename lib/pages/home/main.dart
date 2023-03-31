import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Widget> _sd() {
    List<Widget> array = [];

    for (int i = 0; i < 10; i++) {
      array.add(ListTransactionWidget(i: i));
    }
    return array;
  }

  static const double balance = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
          ),
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
                  Row(
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
                          children: [
                            const Text(
                              'Balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w200),
                            ),
                            const Text(
                              '\$.$balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Text(
                                      '\$.200',
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Text(
                                      '100%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: 1 <= 0
                                              ? Colors.red
                                              : Colors.green),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Text(
                                      '\$.200',
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
                  ),
                  //  filters
                  Row(
                    children:  [
                      IconButton(onPressed:  () => {
                        showDialog(context: context, builder: (BuildContext contex) {
                           return const AlertDialog(
                            content: Text("asdasd"),
                           );
                        })
                      }, icon: const Icon(Icons.filter))
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                decoration: const BoxDecoration(),
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context)
                                    .size
                                    .height
                                    .floorToDouble() /
                                4,
                            maxHeight: MediaQuery.of(context)
                                    .size
                                    .height
                                    .floorToDouble() -
                                100),
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Modal BottomSheet'),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
  }
}

class ListTransactionWidget extends StatefulWidget {
  final int i;

  get ola => i;
  const ListTransactionWidget({Key? key, this.i = 0}) : super(key: key);
  @override
  ListTransactionState createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransactionWidget> {
  bool active = false;

  changeColorCard() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => changeColorCard(),
        onLongPressEnd: (details) => changeColorCard(),
        child: Container(
          decoration: BoxDecoration(
              color: active == true
                  ? widget.i % 2 == 0
                      ? Colors.green[100]
                      : Colors.red[100]
                  : null,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.now().toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(114, 114, 114, 0.498),
                ),
              ),
              Container(
                // decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              widget.i % 2 == 0 ? Icons.check : Icons.error,
                              color:
                                  widget.i % 2 == 0 ? Colors.green : Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              '2323423434',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ]),
                    ),
                    Text(
                      '\$.89729',
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.i % 2 == 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
