import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/main.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:wafi/services/auth.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key, int step = 1}) : super(key: key);
  @override
  ForgotPasswordWidgetState createState() => ForgotPasswordWidgetState();
}

class ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  dynamic error;

  bool obscureTextPassword = true;
  bool loading = false;

  final _emailController = TextEditingController();

  final Map _formData = {"email": ''};

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
                                        controller: _emailController,
                                        onChanged: (value) => setState(() {
                                          _formData['email'] = value;
                                        }),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: lang('Email'),
                                        ),
                                        // initialValue: ,
                                      ),
                                     const SizedBox(height: 20,),
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
                                                    dynamic error = await getToken(
                                                        _emailController.text,
                                                       );

                                                    if (error != null) {
                                                      if (context.mounted) {
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                       SnackBarMessage(context,
                                                            Text(error));
                                                      }
                                                    }
                                                    if (context.mounted &&
                                                        error == null) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Navigator.popAndPushNamed(
                                                          context, '/forgot-password-check-code');
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (context.mounted) {
                                                      SnackBarMessage(context,
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
                                            lang('Get token'),
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
