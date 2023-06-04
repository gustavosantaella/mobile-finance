import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/helpers/fn/main.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/auth.dart';

class ForgotPasswordChange extends StatefulWidget {
  const ForgotPasswordChange({Key? key}) : super(key: key);

  @override
  ForgotPasswordChangeState createState() => ForgotPasswordChangeState();
}

class ForgotPasswordChangeState extends State<ForgotPasswordChange> {
  final _formKey = GlobalKey<FormState>();
  dynamic error;

  bool loading = false;

  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  final Map _formData = {"password": '', "repeatPassword": ""};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        body: SafeArea(
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
            color: Colors.blue,
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appName.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 43,
                              letterSpacing: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          'assets/app_icon.png',
                          width: 145,
                          height: 145,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  height: 350,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        obscureText: true,
                                        controller: _passwordController,
                                        onChanged: (value) => setState(() {
                                          _formData['password'] = value;
                                        }),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: lang('New password'),
                                        ),
                                        // initialValue: ,
                                      ),
                                      const SizedBox(height: 10,),
                                      TextFormField(
                                        controller: _passwordRepeatController,
                                        onChanged: (value) => setState(() {
                                          _formData['repeatPassword'] = value;
                                        }),
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: lang('Repeat password'),
                                        ),
                                        // initialValue: ,
                                      ),
                                     
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: loading == true
                                              ? null
                                              : () async {
                                               
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  bool hasError = false;
                                                  _formData
                                                      .forEach((key, value) {
                                                    if (_formData[key]
                                                        .isEmpty) {
                                                      SnackBarMessage(
                                                          context,
                                                          Colors.red,
                                                          Text(
                                                              'Invalid input for $key'));
                                                      hasError = true;

                                                      return;
                                                    }
                                                  });
                                                  if (hasError) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    return;
                                                  }
                                                  try {
                                                     if(_formData["password"] != _formData['repeatPassword']){
                                                  throw Exception("Password are differents");
                                                }
                                                    bool data =
                                                        await forgotPasswordChange(
                                                      _passwordController.text,
                                                      args["email"]
                                                    );

                                                    if (!data) {
                                                      if (context.mounted) {
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                        SnackBarMessage(
                                                            context,
                                                            Colors.red,
                                                            const Text(
                                                                "Response is empty. Please try agan"));
                                                        Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                '/login');
                                                      }
                                                    }
                                                    if (context.mounted &&
                                                        error == null) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Navigator.popAndPushNamed(
                                                          context,
                                                          '/login');
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (context.mounted) {
                                                      SnackBarMessage(
                                                          context,
                                                          Colors.red,
                                                          Text(e.toString()));
                                                    }
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
                                              backgroundColor: loading == true
                                                  ? MaterialStateProperty.all(
                                                      Colors.grey)
                                                  : MaterialStateProperty.all(
                                                      colorFromHexString(
                                                          definitions['colors'][
                                                                      'background']
                                                                  [
                                                                  'hexadecimal']
                                                              ['cobalto']))),
                                          child: Text(
                                            lang('Change password'),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ))),
      ),
    ));
  }
}
