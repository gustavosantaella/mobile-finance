import 'package:flutter/material.dart';

class BottomSheetWiget extends StatelessWidget {
  const BottomSheetWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(),
          child: IconButton(
              onPressed: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.of(context).size.height.floorToDouble() /
                              2),
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (BuildContext context) {
                    return const AddMovementWidget();
                  },
                );

                print(22323423);
              },
              icon: const Icon(
                Icons.add_circle_rounded,
                size: 60,
                color: Colors.blue,
              )),
        ),
      ),
    );
  }
}

class AddMovementWidget extends StatelessWidget {
  const AddMovementWidget({super.key});

  static bool isExpense = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.attach_money),
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
              )
            ],
          ),
           Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Row(
                children: const [
                  Icon(Icons.category),
                ],
              ),
              Switch(value: isExpense, onChanged: (bool value) {}),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Row(
                children: const [
                  Icon(Icons.arrow_drop_up, color: Colors.green),
                  Icon(Icons.arrow_drop_down, color: Colors.red),
                ],
              ),
              Switch(value: isExpense, onChanged: (bool value) {}),
            ],
          ),
        ElevatedButton(onPressed: (){}, child: const Text("Send"))
        ],
      ),
    );
  }
}
