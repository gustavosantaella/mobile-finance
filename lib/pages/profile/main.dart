import 'package:finance/helpers/fn/lang.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/services/auth.dart';
import 'package:finance/services/user.dart' as userService;
import 'package:finance/widgets/navigation_bar.dart';
import 'package:finance/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  late Map data = {};

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getUser() async {
      Map response = await userService.getUser();
      print(response);
      setState(() {
        data = response;
      });

      _emailController.text = data['email'] ?? 'without email';
    }

    if (data.isEmpty) {
      getUser();
    }

    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(lang("Profile")),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: const NavigationBarWidget(),
        body: SafeArea(
          child: FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: Container(
                color: appProvider.currentBackground,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // here
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: SingleChildScrollView(
                                    child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                  hintText: data['email'] ?? '',
                                                  label: const Text("Email"),
                                                  border:
                                                      const OutlineInputBorder())),
                                          ElevatedButton(
                                              onPressed: () async {
                                                if (_emailController
                                                    .value.text.isEmpty) {
                                                  return;
                                                }

                                                String value =
                                                    _emailController.value.text;

                                                try {
                                                  await userService
                                                      .updateUserInfro(
                                                          {"email": value});
                                                  if (context.mounted) {
                                                    SnackBarMessage(
                                                        context,
                                                        Colors.green,
                                                        const Text(
                                                            'Successfully'));
                                                  }
                                                } catch (e) {
                                                  SnackBarMessage(
                                                      context,
                                                      Colors.red,
                                                      Text(e.toString()));
                                                }
                                              },
                                              child: Text(lang('Submit')))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Text(
                                                'Color de fondo',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          CircleColorPicker(
                                            onChanged: (color) => appProvider
                                                .backgroundApp = color,
                                            size: const Size(240, 240),
                                            strokeWidth: 4,
                                            thumbSize: 36,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextButton(
                                              style: const ButtonStyle(
                                                padding:
                                                    MaterialStatePropertyAll(
                                                        EdgeInsets.all(10)),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.red),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      final passwordController =
                                                          TextEditingController();
                                                      return Dialog(
                                                          child: Wrap(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextField(
                                                                    controller:
                                                                        passwordController,
                                                                    decoration: const InputDecoration(
                                                                        label: Text(
                                                                            "New password"),
                                                                        border:
                                                                            OutlineInputBorder())),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (passwordController
                                                                          .value
                                                                          .text
                                                                          .isEmpty) {
                                                                        return;
                                                                      }

                                                                      String
                                                                          value =
                                                                          passwordController
                                                                              .value
                                                                              .text;

                                                                      try {
                                                                        await userService
                                                                            .updateUserInfro({
                                                                          "password":
                                                                              value
                                                                        });
                                                                        if (context
                                                                            .mounted) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          SnackBarMessage(
                                                                              context,
                                                                              Colors.green,
                                                                              Text(lang('Successfully')));
                                                                        }
                                                                      } catch (e) {
                                                                        SnackBarMessage(
                                                                            context,
                                                                            Colors.red,
                                                                            Text(e.toString()));
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        lang(
                                                                            'Submit')))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                    });
                                              },
                                              child: Text(
                                                lang("Reset password"),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              )),
                                        ],
                                      ),
                                      TextButton(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.all(10)),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.red),
                                          ),
                                          onPressed: () async {
                                            await Future.wait([
                                              walletProvider.clearAll(),
                                              logout()
                                            ]);
                                            if (context.mounted) {
                                              Navigator.popAndPushNamed(
                                                  context, '/login');
                                            }
                                          },
                                          child: Text(
                                            lang("Logout"),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ))
                                    ],
                                  ),
                                )),
                              )),
                        ),
                      ],
                    ))),
          ),
        ));
  }
}
