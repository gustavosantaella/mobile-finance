import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/main.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:wafi/services/auth.dart';

class ForgotPasswordCheckCode extends StatefulWidget {
  const ForgotPasswordCheckCode({Key? key}) : super(key: key);
  @override
  ForgotPasswordCheckCodeState createState() => ForgotPasswordCheckCodeState();
}

class ForgotPasswordCheckCodeState extends State<ForgotPasswordCheckCode> {
  final _formKey = GlobalKey<FormState>();
  dynamic error;

  bool loading = false;

  final _codeController = TextEditingController();

  final Map _formData = {"code": ''};

  @override
  Widget build(BuildContext context) {
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
                                        controller: _codeController,
                                        onChanged: (value) => setState(() {
                                          _formData['code'] = value;
                                        }),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: lang('Verification code'),
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
                                                      SnackBarMessage(context,
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
                                                    String data =
                                                        await forgotPasswordValidateCode(
                                                      _codeController.text,
                                                    );

                                                    if (data.isEmpty) {
                                                      if (context.mounted) {
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                       SnackBarMessage(context,
                                                            const Text(
                                                                "Response is empty. Please try agan"));
                                                        Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                '/login');
                                                      }
                                                    }
                                                    if (context.mounted && data.isNotEmpty) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Navigator.popAndPushNamed(
                                                          context,
                                                          '/forgot-password-change-password', arguments: {
                                                            "email": data
                                                          });
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (context.mounted) {
                                                      SnackBarMessage(context,
                                                          Text(e.toString()));
                                                          Navigator.pop(context);
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
                                            lang('Check token'),
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
