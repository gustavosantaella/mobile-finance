import 'package:finance/helpers/fn/norifications.dart';
import 'package:finance/pages/list/main.dart';
import 'package:finance/providers/drawe_provider.dart';
import 'package:finance/services/cron.dart';
import 'package:finance/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:finance/pages/calendar/main.dart';
import 'package:finance/pages/login/main.dart';
import 'dart:ui';
import 'package:finance/pages/home/main.dart';
import 'package:finance/pages/profile/main.dart';
import 'package:finance/pages/register/main.dart';
import 'package:finance/providers/app_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/wallet_provider.dart';
import 'package:finance/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Logger logger = Logger();
void main() async {
  try {
    logger.v("lang: ${window.locale.languageCode}");

    WidgetsFlutterBinding.ensureInitialized();

    runApp(const SplashScreen());
 
    await initNotifications();
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Future.delayed(const Duration(seconds: 5));
    String token = await getuserToken();
    runApp(App(
      token: token,
    ));
  } catch (e) {
    logger.e(e);
    runApp(const App());
  }
}

class App extends StatefulWidget {
  final String token;

  const App({this.token = '', super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
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
          ChangeNotifierProvider<DrawerProvider>(
            create: (context) => DrawerProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<WalletProvider>(
            create: (context) => WalletProvider(),
          ),
        ],
        child: MaterialApp(
          initialRoute: widget.token.isEmpty ? '/login' : '/home',
          routes: {
            "/login": (context) => const LoginWidget(),
            "/register": (context) => const RegisterWidget(),
            "/home": (context) => const HomePage(),
            "/calendar": (context) => const CalendarWidget(),
            "/profile": (context) => const UserProfile(),
            "/list": (context) => const ListTransactionsWidget(),
          },
        ),
      ),
    );
  }
}
