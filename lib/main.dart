import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/norifications.dart';
import 'package:wafi/pages/forgotPassword/ForgotPasswordChange.dart';
import 'package:wafi/pages/forgotPassword/ForgotPasswordCheckCode.dart';
import 'package:wafi/pages/forgotPassword/main.dart';
import 'package:wafi/pages/list/main.dart';
import 'package:wafi/pages/schedules/main.dart';
import 'package:wafi/providers/drawe_provider.dart';
import 'package:wafi/services/cron.dart';
import 'package:wafi/widgets/snack_bar.dart';
import 'package:wafi/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wafi/pages/calendar/main.dart';
import 'package:wafi/pages/login/main.dart';
import 'dart:ui';
import 'package:wafi/pages/home/main.dart';
import 'package:wafi/pages/profile/main.dart';
import 'package:wafi/pages/register/main.dart';
import 'package:wafi/providers/app_provider.dart';
import 'package:wafi/providers/user_provider.dart';
import 'package:wafi/providers/wallet_provider.dart';
import 'package:wafi/services/auth.dart';
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

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black87));
    super.initState();
  }

  void a() async {
    while (true) {
      final SnackBar snackBar =
          SnackBar(content: Text("your snackbar message"));
            showNotificacion(title: lang("Hey!, I'm sad"), content:lang( "You have not used me"), id: 1);
      snackbarKey.currentState?.showSnackBar(snackBar);
      print(234);
      await Future.delayed(Duration(seconds: 5));
    }
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
          scaffoldMessengerKey: snackbarKey,
          initialRoute: widget.token.isEmpty ? '/login' : '/home',
          routes: {
            "/login": (context) => const LoginWidget(),
            "/forgot-password": (context) => const ForgotPasswordWidget(),
            "/forgot-password-check-code": (context) =>
                const ForgotPasswordCheckCode(),
            "/forgot-password-change-password": (context) =>
                const ForgotPasswordChange(),
            "/register": (context) => const RegisterWidget(),
            "/home": (context) => const HomePage(),
            "/calendar": (context) => const CalendarWidget(),
            "/profile": (context) => const UserProfile(),
            "/list": (context) => const ListTransactionsWidget(),
            "/schedules": (context) => const ScheduleWidget(),
          },
        ),
      ),
    );
  }
}
