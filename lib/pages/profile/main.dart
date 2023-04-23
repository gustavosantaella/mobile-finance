import 'package:finance/config/constanst.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/widgets/navigation_bar.dart';
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
  Color _currentColor = Colors.red;

  final TextEditingController _emailContronler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Profile"),
          backgroundColor: appProvider.currentBackground,
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
                        Container(
                          margin: const EdgeInsets.all(1),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                data['name'] ?? 'Loading name...',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
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
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                              decoration: InputDecoration(
                                                  hintText: data['email'] ?? '',
                                                  label: const Text("Email"),
                                                  border:
                                                      const OutlineInputBorder())),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('Submit'))
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
                                                'Choice background',
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
                                              onPressed: () {},
                                              child: const Text(
                                                "Reset password",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              )),
                        )
                      ],
                    ))),
          ),
        ));
  }
}
