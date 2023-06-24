import 'package:flutter/material.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/widgets/card_widget.dart';
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:wafi/widgets/tag_widget.dart';

class LoansWidget extends StatefulWidget {
  const LoansWidget({super.key});

  @override
  LoandsState createState() => LoandsState();
}

Widget buttoms(BuildContext context, String text, VoidCallback callback) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2.3,
    child: TextButton(
      onPressed: callback,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.all(15)),
          backgroundColor:
              MaterialStatePropertyAll(definitions['colors']['cobalto'])),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

class LoandsState extends State<LoansWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(lang("Loans"), subTitle: lang("My debts")),
        bottomNavigationBar: const NavigationBarWidget(),
        body: Container(
            color: Colors.white,
            child: Container(
              margin: marginAll,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buttoms(context, lang('Debts'), () {}),
                          buttoms(context, lang('Loans'), () {}),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "${lang("Search")}...",
                            suffixIcon: const Icon(Icons.search)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      printCards(),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ))
                ],
              ),
            )));
  }
}

Widget printCards() {
  return SizedBox(
    child: Column(
      children: [
        CardWidget(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Gustavo",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Tag("canceled", TagColorOptions.canceled),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Deserunt eiusmod excepteur esse eiusmod deserunt laborum magna eu Lorem culpa esse culpa sit. In enim non Lorem occaecat enim mollit do in sit Lorem veniam. Dolore adipisicing incididunt minim excepteur eiusmod quis cillum. Minim minim fugiat excepteur minim do pariatur exercitation sunt commodo sit excepteur eu. Et ea commodo consequat aliqua consectetur irure aliqua dolore Lorem.",
              textAlign: TextAlign.justify,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "\$.20",
              textAlign: TextAlign.justify,
              maxLines: 2,
            )
          ],
        )),
        // 
        CardWidget(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Luis",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Tag("success", TagColorOptions.success),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Deserunt eiusmod excepteur esse eiusmod deserunt laborum magna eu Lorem culpa esse culpa sit. In enim non Lorem occaecat enim mollit do in sit Lorem veniam. Dolore adipisicing incididunt minim excepteur eiusmod quis cillum. Minim minim fugiat excepteur minim do pariatur exercitation sunt commodo sit excepteur eu. Et ea commodo consequat aliqua consectetur irure aliqua dolore Lorem.",
              textAlign: TextAlign.justify,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "\$.20",
              textAlign: TextAlign.justify,
              maxLines: 2,
            )
          ],
        )),
        // 
        CardWidget(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Glendimar",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Tag("pending", TagColorOptions.warning),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Deserunt eiusmod excepteur esse eiusmod deserunt laborum magna eu Lorem culpa esse culpa sit. In enim non Lorem occaecat enim mollit do in sit Lorem veniam. Dolore adipisicing incididunt minim excepteur eiusmod quis cillum. Minim minim fugiat excepteur minim do pariatur exercitation sunt commodo sit excepteur eu. Et ea commodo consequat aliqua consectetur irure aliqua dolore Lorem.",
              textAlign: TextAlign.justify,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "\$.20",
              textAlign: TextAlign.justify,
              maxLines: 2,
            )
          ],
        )),
      ],
    ),
  );
}
