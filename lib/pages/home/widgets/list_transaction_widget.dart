import 'package:wafi/helpers/fn/bottom_sheets.dart';
import 'package:wafi/widgets/history_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wafi/config/constanst.dart';
import 'package:intl/intl.dart';

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
        onTap: () {
          changeColorCard();
          bottomSheetWafi(context, HistoryDetail(widget.data['_id']));
        },
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
                (widget.data['createdAt'] != null) || widget.data['created_at'] != null
                    ? DateFormat('dd/MM/yyyy HH:mm:ss a')
                        .format(DateTime.parse(widget.data['createdAt'] ?? widget.data['created_at']))
                    : "Without date",
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
                              definitions['history']?['type']
                                      ?[widget.data['type']]?['icon'] ??
                                  definitions['colors']?['default'],
                              color: definitions['history']?['type']
                                      ?[widget.data['type']]?['color'] ??
                                  definitions['colors']?['default'],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            

                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  widget.data['historyId'] ??
                                      widget.data['_id'],
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ))
                          ]),
                    ),
                    Text(
                      "\$.${widget.data['value']}",
                      style: TextStyle(
                          fontSize: 18,
                          color: definitions['history']['type']
                                  ?[widget.data['type']]?['color'] ??
                              definitions['colors']['default']),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
