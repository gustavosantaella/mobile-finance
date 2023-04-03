import 'package:flutter/material.dart';
import 'package:finance/config/constanst.dart';

class ListTransactionWidget extends StatefulWidget {
  final int i;
  final Map data;

  const ListTransactionWidget(this.data, {Key? key, this.i = 0})
      : super(key: key);
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
              color: active == true ? Colors.grey[200] : null, 
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['createdAt']?.toString() ?? "Without date",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(114, 114, 114, 0.498),
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
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
                              definitions['history']['type']
                                      ?[widget.data['type']]?['icon'] ??
                                  definitions['colors']['default'],
                              color: definitions['history']['type']
                                      ?[widget.data['type']]?['color'] ??
                                  definitions['colors']['default'],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.data['historyId'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ]),
                    ),
                    Text(
                      "\$.${widget.data['value']}",
                      style: TextStyle(
                        fontSize: 18,
                        color: definitions['history']['type']
                                ?[widget.data['type']]?['color'] ??
                            definitions['colors']['default']
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
