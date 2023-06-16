import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/providers/app_provider.dart';
import 'package:wafi/providers/wallet_provider.dart';
import 'package:wafi/services/auth.dart';
import 'package:wafi/services/user.dart' as userService;
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:wafi/helpers/fn/main.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Map data = {
    // "email":""
  };

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
        bottomNavigationBar: const NavigationBarWidget(),
        body: SafeArea(
          child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: SingleChildScrollView(
                child: Container(
                  margin: marginAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Text(
                              lang("Profile"),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Row(children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                43, 28, 26, 26)),
                                        color: const Color.fromARGB(
                                            86, 158, 158, 158),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100))),
                                    child: IconButton(
                                        // icon
                                        alignment: Alignment.center,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.person,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${lang('hi')}, ${emailIdentifier(data['email'] ?? '')}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        data['email'] ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: definitions['colors']
                                                    ['cobalto'],
                                                borderRadius: borderRadiusAll),
                                            child: const Text(
                                              "WAFI PREMIUM",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                    ],
                                  ),
                                ]),
                              )
                            ],
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(top: 20),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         lang('My objectives:'),
                          //         style: const TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.w400),
                          //       ),
                          //       objectives(widget),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      listElements(context),
                      TextButton(
                          onPressed: () async {
                            await logout();
                            if (context.mounted) {
                              Navigator.of(context).popAndPushNamed('/login');
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: borderRadiusAll),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              lang('Logout'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              )),
        ));
  }
}

SingleChildScrollView objectives(widget) {
  try {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: definitions['colors']['cobalto'],
                    borderRadius: borderRadiusAll),
                child: Text(
                  lang('Ahorrar'),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: definitions['colors']['cobalto'],
                    borderRadius: borderRadiusAll),
                child: Text(
                  lang('Invertir'),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: definitions['colors']['cobalto'],
                    borderRadius: borderRadiusAll),
                child: Text(
                  lang('Ahorrar'),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  } catch (e) {
    return const SingleChildScrollView();
  }
}

SizedBox listElements(context, {widget, data}) {
  final passwordController = TextEditingController();
  return SizedBox(
      child: Column(
    children: [
      ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(lang("Reset password")),
          children: [
             Text(
                lang('If you want to reset password, you can to insert a new password in  the following input, after that you can login whit your new password.')),
            Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          controller: passwordController,
                          decoration:  InputDecoration(
                              label: Text(lang("New password")),
                              border: const OutlineInputBorder())),
                      ElevatedButton(
                          onPressed: () async {
                            if (passwordController.text.isEmpty) {
                              print('empty');
                              return;
                            }

                            String value = passwordController.value.text;

                            try {
                              await userService
                                  .updateUserInfro({"password": value});
                              if (context.mounted) {
                                SnackBarMessage(
                                    context, Text(lang('Successfully')),
                                    color: Colors.green);
                              }
                            } catch (e) {
                              print("errorrr");
                              print(e);
                              SnackBarMessage(context, Text(e.toString()));
                            }
                          },
                          child: Text(lang('Submit')))
                    ],
                  ),
                ),
              ],
            ),
          ]),
      ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(lang("Change subscription")),
        children:  [
          Text(lang('This feature is beign developed')),
        ],
      ),
      ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(lang("Restore finances")),
        children: [
          Text(lang(
              'This action is very dangerous because delete your finance history. Then you can register new finances again. \n\n This is very used to restore your history or if you need restore your balance.')),
          TextButton(
              onPressed: () async {},
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red, borderRadius: borderRadiusAll),
                padding: const EdgeInsets.all(10),
                child: Text(
                  lang('Restore'),
                  style: const TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(lang("Delete account")),
        children: [
          const Text(
              'This action is permanently. If you are not sure of that you can close this Menu.'),
          TextButton(
              onPressed: () async {},
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red, borderRadius: borderRadiusAll),
                padding: const EdgeInsets.all(10),
                child: Text(
                  lang('Delete account'),
                  style: const TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    ],
  ));
}
