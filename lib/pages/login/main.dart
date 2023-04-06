import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/auth.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  dynamic error;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              child: FractionallySizedBox(
                  heightFactor: 0.5,
                  child: Wrap(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "WAFI",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.wallet),
                                ],
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value != null &&
                                            !value.contains('@')) {
                                          return "Invalid Email";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          label: Text("Username"),
                                          border: OutlineInputBorder()),
                                    ),
                                    const Divider(),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                          label: Text("Password"),
                                          border: OutlineInputBorder()),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          bool isValid = _formKey.currentState
                                              ?.validate() as bool;
                                          if (!isValid) {
                                            return;
                                          }

                                          dynamic error = await login(
                                              emailController.text,
                                              passwordController.text);
                                          if (context.mounted && error != null) {
                                            SnackBarMessage(context, Colors.red,
                                                Text(error));
                                            return;
                                          }

                                          if(context.mounted && error == null){
                                            await Navigator.pushNamed(context, '/home');
                                          }
                                        },
                                        child: const Text("Submit"))
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  )))),
    );
  }
}
