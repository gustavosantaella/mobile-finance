import 'package:flutter/material.dart';
import 'package:finance/config/constanst.dart';
import 'package:finance/pages/calendar/main.dart';
import 'package:finance/pages/login/main.dart';
import 'package:finance/pages/home/main.dart';
import 'package:finance/pages/profile/main.dart';
import 'package:finance/pages/register/main.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();

  String token = await getuserToken();
  runApp(App(token: token,));
  }catch(e){
  runApp(const App());
  }
}

class App extends StatefulWidget {

  final String token;

  const App({this.token ='', super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool loading = false;
  bool hasToken = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black87));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AppProvider>(
            create: (context) => AppProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<WalletProvider>(
            create: (context) => WalletProvider(),
          ),
        ],
        child:  MaterialApp(
                initialRoute: widget.token.isEmpty ? '/login' :'/home',
                routes: {
                  "/login": (context) => const LoginWidget(),
                  "/register": (context) => const RegisterWidget(),
                  "/home": (context) => const HomePage(),
                  "/calendar": (context) => const CalendarWidget(),
                  "/profile": (context) => const UserProfile(),
                },
              ),
      ),
    );
  }
}
