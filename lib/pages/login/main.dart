import 'package:finance/config/constanst.dart';
import 'package:finance/helpers/fn/main.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/auth.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  dynamic error;
  bool loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Map _formData = {"email": '', "password": ''};

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
            color: definitions['colors']['background']['app'],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        onChanged: (value) => setState(() {
                                          _formData['email'] = value;
                                        }),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: 'Email',
                                        ),
                                        // initialValue: ,
                                      ),
                                      TextFormField(
                                        controller: _passwordController,
                                        onChanged: (value) => setState(() {
                                          _formData['password'] = value;
                                        }),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          labelText: 'Password',
                                        ),
                                        // initialValue: '',
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
                                                const      Duration(seconds: 1));
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
                                                    dynamic error = await login(
                                                        _emailController.text,
                                                        _passwordController
                                                            .text,
                                                        userProvider:
                                                            userProvider);
                                                    if (error != null) {
                                                      if (context.mounted) {
                                                        SnackBarMessage(
                                                            context,
                                                            Colors.red,
                                                            Text(error));
                                                      }
                                                    }
                                                    if (context.mounted &&
                                                        error == null) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Navigator.popAndPushNamed(
                                                          context, '/home');
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    // if(context.mounted){
                                                    //   SnackBarMessage(
                                                    //     context,
                                                    //     Colors.red,
                                                    //     Text(e.toString()));
                                                    // }
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
                                          child: const Text(
                                            'Sign In',
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
                                            "Register now",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.popAndPushNamed(
                                                    context, '/register');
                                              },
                                              child: const Text(
                                                "Sign up",
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
                ))),
      ),
    ));
  }
}
