import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/main.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:wafi/providers/app_provider.dart';
import 'package:wafi/providers/user_provider.dart';
import 'package:wafi/services/auth.dart';
import 'package:wafi/widgets/snack_bar.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AppProvider appProvider = Provider.of(context, listen: true);
    return Container(
        decoration: const BoxDecoration(borderRadius: borderRadiusAll),
        // margin: const EdgeInsets.all(10),
        child: FloatingNavbar(
          onTap: (int value) async {
            switch (value) {
              case 0:
                await route(context, '/home');
                break;
              case 1:
                await route(context, '/loans');
                break;
              case 2:
                await route(context, '/list');
                break;
              case 3:
                await route(context, '/calendar');
                break;

              default:
                SnackBarMessage(context, lang("404:Route not found"));
                break;
            }
          },
          currentIndex: 0,
          backgroundColor: definitions['colors']['cobalto'],
          // height: MediaQuery.of(context).size.height / 12,
          // notchMargin: 10,
          padding: const EdgeInsets.only(bottom: 8, top: 10),
          // shape: const CircularNotchedRectangle(),
          elevation: 0,
          items: [
            FloatingNavbarItem(icon: Icons.home),
            FloatingNavbarItem(icon: Icons.article),
            FloatingNavbarItem(icon: Icons.list),
            FloatingNavbarItem(icon: Icons.calendar_month),
          ],
          // height: MediaQuery.of(context).size.height,
          // color: definitions['colors']['cobalto'],
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [

          //   IconButton(
          //       onPressed: () async {
          //         await route(context, '/loans');
          //       },
          //       icon: const Icon(
          //         Icons.article,
          //         color: Colors.white,
          //       )),
          //   IconButton(
          //       onPressed: () async {
          //         if (ModalRoute.of(context)?.settings.name == '/list') return;

          //         await Navigator.popAndPushNamed(context, '/list');
          //       },
          //       icon: const Icon(
          //         Icons.list,
          //         color: Colors.white,
          //       )),
          //   IconButton(
          //       onPressed: () async {
          //         if (ModalRoute.of(context)?.settings.name == '/calendar')
          //           return;

          //         await Navigator.popAndPushNamed(context, '/calendar');
          //       },
          //       icon: const Icon(
          //         Icons.calendar_month,
          //         color: Colors.white,
          //       )),
          // ],
          // )
        ));
  }
}

AppBar appBarWidget(BuildContext context, String title,
        {String? subTitle, Widget? leading, GlobalKey<ScaffoldState>? key}) =>
    AppBar(
      leading: leading,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (key == null) {
                      return;
                    }
                    if (key.currentState != null) {
                      key.currentState!.closeDrawer();
                    }
                    key.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
            ],
          ),
          if (subTitle != null)
            Text(
              subTitle,
              style: const TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
        ],
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.white,
    );

Drawer mainDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, "/profile");
          },
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person),
                      Text(
                        lang("My account"),
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: definitions['colors']['cobalto'],
                            borderRadius: borderRadiusAll),
                        child: const Text(
                          "WAFI PREMIUM",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(lang('Home')),
          onTap: () {
            Navigator.popAndPushNamed(context, "/home");
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text(lang('Conversions')),
          onTap: () {
            Navigator.pushNamed(context, '/conversion');
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text(lang("New wallet")),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text(
            lang("Logout"),
            style: const TextStyle(color: Colors.red),
          ),
          onTap: () {
            try {
              logout();
              Navigator.popAndPushNamed(context, '/login');
            } catch (e) {
              SnackBarMessage(context, e.toString());
            }
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
