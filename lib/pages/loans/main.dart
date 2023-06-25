import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/bottom_sheets.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/pages/loans/new_loan_widget.dart';
import 'package:wafi/services/home.dart';
import 'package:wafi/services/loan.dart';
import 'package:wafi/widgets/card_widget.dart';
import 'package:wafi/widgets/categories_widget.dart';
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:wafi/widgets/tag_widget.dart';

Logger logger = Logger();

class LoansWidget extends StatefulWidget {
  const LoansWidget({super.key});

  @override
  LoandsState createState() => LoandsState();
}

class LoandsState extends State<LoansWidget> {
  bool isLoading = false;
  bool isLoanTab = false;
  bool hasError = false;
  //  original list
  List loans = [];
  //  aux list when we are filtering
  List auxLoans = [];

  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  _getLoans({int attemp = 1}) {
    setState(() {
      hasError = false;
      isLoading = true;
    });
    getLoansByType(isLoanTab).then((data) {
      setState(() {
        loans = data;
        auxLoans = data;
        isLoading = false;
      });
    }).catchError((onError) {
      logger.e(onError, attemp != maxAttemps);
      if (attemp != maxAttemps) {
        return _getLoans(attemp: attemp + 1);
      }
      SnackBarMessage(context, lang("An error curred"));
      setState(() {
        hasError = true;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getLoans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scafoldKey,
        extendBody: false,
        appBar: appBarWidget(
          context,
          lang("Loans"),
          subTitle: isLoanTab == false ? lang("My debts") : lang('My leans'),
        ),
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
                          buttoms(context, lang('Debts'), () {
                            setState(() {
                              isLoanTab = false;
                            });
                            _getLoans();
                          }),
                          buttoms(context, lang('Loans'), () {
                            setState(() {
                              isLoanTab = true;
                            });
                            _getLoans();
                          }),
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
                      if (isLoading == true && hasError == false)
                        const CircularProgressIndicator()
                      else if (loans.isNotEmpty)
                        printCards(context, auxLoans, onDelete: (loan) async {
                          try {
                            await deleteLoan(loan["_id"]);
                            loans.removeWhere(
                                (element) => element['_id'] == loan['_id']);
                            setState(() {
                              loans = loans;
                            });
                          } catch (error) {
                            SnackBarMessage(context, error.toString());
                          }
                        }, widget: this)
                      else
                        TextButton(
                          child: Text(lang('Try again')),
                          onPressed: () {
                            _getLoans();
                          },
                        )
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: FloatingActionButton(
                        onPressed: () {
                          bottomSheetWafi(
                              context,
                              NewLoanWidget(
                                isLoanTab,
                                setStateCallbackLoans: (e) {
                                  setState(() {
                                    auxLoans = [...loans, e];
                                  });
                                },
                              ));
                        },
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

Widget printCards(BuildContext context, List<dynamic> loans,
    {Function? onDelete, LoandsState? widget}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height / 1.8,
    child: ListView(
      children: loans
          .map((e) => TextButton(
                onPressed: () {
                  List<String> types = definitions['loans']['types'];
                  types =
                      types.where((element) => element != e['status']).toList();
                  List<Widget> l = types
                      .map((String el) => TextButton(
                          onPressed: () async {
                            try {
                              await updateStatus(el, e['_id']);
                              int loanIndex = loans.indexWhere(
                                  (element) => element["_id"] == e['_id']);
                              if (loanIndex > -1) {
                                loans[loanIndex]['status'] = el;
                                widget?.setState(() {
                                    loans = [...loans];
                                });
                              }
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              Navigator.pop(context);

                              SnackBarMessage(context, e.toString());
                            }
                          },
                          child: Tag(el, TagColorOptions.getColor(el))))
                      .toList();
                  bottomSheetWafi(
                      context,
                      SizedBox(
                        child: Container(
                          margin: marginAll,
                          child: Wrap(
                            children: [
                              Text(
                                lang(
                                    "Update the status whe you know some advance about your loans."),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Wrap(
                                    runSpacing: 20,
                                    spacing: 20,
                                    children: [...l]),
                              )
                            ],
                          ),
                        ),
                      ));
                },
                child: CardWidget(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 200,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "${e['who']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                            )),
                        Row(
                          children: [
                            Tag("${e?['status']}",
                                TagColorOptions.getColor(e?['status'])),
                            IconButton(
                              onPressed: () {
                                if (onDelete != null) {
                                  onDelete(e);
                                }
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${e?['description'] ?? ''}",
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${lang('Category')}: Streaming",
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${lang('Amount')}: \$.${e['amount']}",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )),
              ))
          .toList(),
    ),
  );
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
