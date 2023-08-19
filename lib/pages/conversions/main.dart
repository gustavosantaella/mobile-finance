import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/services/currency.dart';
import 'package:wafi/widgets/fn.dart';
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:wafi/widgets/snack_bar.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  ConversionState createState() => ConversionState();
}

class ConversionState extends State<ConversionScreen> {
  late Map<String, dynamic> currencies = {};
  double converted = 0.0;
  double fromConvert = 0.0;
  double toConvert = 0.0;
  String from = "VES";
  String to = "USD";
  final TextEditingController _fromConvertController = TextEditingController();
  final TextEditingController _tomConvertController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getCurrencies(context) async {
    try {
      Map<String, dynamic> data = await getCurrenciesApi();
      setState(() {
        currencies = data;
      });
    } catch (e) {
      SnackBarMessage(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _tomConvertController.text = "0.00";
    _fromConvertController.text = "0.00";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currencies.isEmpty) {
      getCurrencies(context);
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: mainDrawer(context),
      appBar: appBarWidget(context, lang("Conversions"), key: _scaffoldKey),
      bottomNavigationBar: const NavigationBarWidget(),
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "${converted.toStringAsFixed(4)}\$",
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 30,
              children: [
                FractionallySizedBox(
                  widthFactor: .2,
                  child: Column(
                    children: [
                      dropdownCurrencies(currencies, from, (value) {
                        setState(() {
                          from = value;
                        });
                      }),
                      TextField(
                        controller: _fromConvertController,
                        keyboardType: TextInputType.number,
                      )
                    ],
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .2,
                  child: IconButton(
                      onPressed: () async {
                        try {
                          double data = await getConversion(
                              from, to, _fromConvertController.text);
                          setState(() {
                            converted = data;
                          });
                        } catch (e) {
                          return;
                        }
                      },
                      icon: const Icon(
                        Icons.change_circle_outlined,
                        size: 50,
                      )),
                ),
                FractionallySizedBox(
                  widthFactor: .2,
                  child: Column(
                    children: [
                      dropdownCurrencies(currencies, to, (value) {
                        setState(() {
                          to = value;
                        });
                      }),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
