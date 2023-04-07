import 'package:finance/pages/login/main.dart';
import 'package:finance/pages/home/main.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:finance/database/main.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider<UserProvider>(create: (context) =>  UserProvider(),),
        ChangeNotifierProvider<WalletProvider>(create: (context) =>  WalletProvider(),),
      ],
      child: MaterialApp(
        routes: {
          "/": (context) => const  LoginWidget(),
          "/home": (context) => const  HomePage(),
        },
      ),
    );
  }
}


