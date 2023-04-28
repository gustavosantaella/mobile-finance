import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/main.dart';
import 'package:finance/services/auth.dart';
import 'package:finance/services/country.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

const fontFamily = 'ubuntu';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();
  Map _formData = {"password": "", "email": "", "country": ""};

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _countryController = TextEditingController();
  late Future<List<dynamic>> _countriesFuture;
  late List<dynamic> _countries = [];
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _countriesFuture = getCountriesKeys();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDropdown() {
      _countriesFuture.then((response) {
        _countries = response.map<String>((item) {
          return item;
        }).toList();
      }).catchError((error) {
        SnackBarMessage(context, Colors.red, Text(error.toString()));
      });
      return DropdownButtonFormField(
          items: _countries
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(
                      width: 200,
                      child: Text(item.toString()),
                    ),
                  ))
              .toList(),
          decoration: GeneralInputStyle(),
          hint: const Text('Country'),
          onChanged: (country) {
            setState(() {
              _formData['country'] = country;
            });
          });
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                    color: Color(int.parse("#38b6ff".substring(1), radix: 16) +
                        0xff000000),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(appName.toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 43.0,
                                          fontFamily: fontFamily,
                                          color: Colors.white)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Image.asset(
                                    'assets/app_icon.png',
                                    width: 68,
                                    height: 68,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Just one step for you to start managing your finance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 3,
                                    color: Colors.white,
                                    fontFamily: fontFamily,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Form(
                                  key: _formKey,
                                  child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        height: 350,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextFormField(
                                              controller: _emailController,
                                              onChanged: (value) =>
                                                  setState(() {
                                                _formData['email'] = value;
                                              }),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                labelText: 'Email',
                                              ),
                                              // initialValue: ,
                                            ),
                                            TextFormField(
                                              controller: _passwordController,
                                              onChanged: (value) =>
                                                  setState(() {
                                                _formData['password'] = value;
                                              }),
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                labelText: 'Password',
                                              ),
                                              // initialValue: '',
                                            ),
                                            Flexible(
                                                child: Container(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                            child:
                                                                RefreshIndicator(
                                              key: _refreshIndicatorKey,
                                              onRefresh: () {
                                                return getCountriesKeys();
                                              },
                                              child: buildDropdown(),
                                            )))),
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextButton(
                                                onPressed: () async {
                                                  _formData
                                                      .forEach((key, value) {
                                                    if (_formData[key]
                                                        .isEmpty) {
                                                      SnackBarMessage(
                                                          context,
                                                          Colors.red,
                                                          Text(
                                                              'Invalid input for $key'));
                                                      return;
                                                    }
                                                  });
                                                  try {
                                                    await registerUser(
                                                        _formData);
                                                    if (context.mounted) {
                                                      Navigator.popAndPushNamed(
                                                          context, '/login');
                                                    }
                                                  } catch (e) {
                                                    SnackBarMessage(
                                                        context,
                                                        Colors.red,
                                                        Text(e.toString()));
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0), // Aquí se establece el radio del borde
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty
                                                        .all(colorFromHexString(
                                                            definitions['colors']
                                                                        [
                                                                        'background']
                                                                    [
                                                                    'hexadecimal']
                                                                ['cobalto']))),
                                                child: const Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Have an account?',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.popAndPushNamed(
                                                          context, '/login');
                                                    },
                                                    child: const Text(
                                                      "Sign In",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    )))));
  }
}
