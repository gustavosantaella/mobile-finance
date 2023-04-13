import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              child: FractionallySizedBox(
                  heightFactor: 0.4,
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
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Row(
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
                                        style:  ButtonStyle(
                                          backgroundColor: loading  ? const MaterialStatePropertyAll(Colors.grey) : null
                                        ),
                                        onPressed: loading ? null :  ()  async {
                                          setState(() {
                                            loading = true;
                                          });
                                          bool isValid = _formKey.currentState
                                              ?.validate() as bool;
                                          if (!isValid) {
                                            setState(() {
                                              loading = false;
                                            });
                                            return;
                                          }

                                          dynamic error = await login(
                                              emailController.text,
                                              passwordController.text,
                                              walletProvider: provider,
                                              userProvider: userProvider
                                              );
                                          if (context.mounted && error != null) {
                                            setState(() {
                                              loading = false;
                                            });
                                            SnackBarMessage(context, Colors.red,
                                                Text(error));
                                            return;
                                          }

                                          if(context.mounted && error == null){
                                            setState(() {
                                              loading = false;
                                            });
                                             Navigator.popAndPushNamed(context, '/home');
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
