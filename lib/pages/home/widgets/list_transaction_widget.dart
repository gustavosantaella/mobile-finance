import 'package:flutter/material.dart';

class ListTransactionWidget extends StatefulWidget {
  final int i;

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
