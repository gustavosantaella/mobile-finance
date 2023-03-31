import 'package:finance/pages/home/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // TODO: implement initState
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,);
SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.blue
));
    super.initState();
  }

  //  @override
  // void dispose() {
  //   super.dispose();

  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) =>  HomePage(),
        "/details": (context) =>  HomePage()
      },
    );
  }
}
