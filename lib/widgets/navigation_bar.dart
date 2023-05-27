import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: MediaQuery.of(context).size.height / 15,
      backgroundColor: Colors.blue,
      destinations: [
        IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/home') return;

              await Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.home, color: Colors.white)),
        IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/list') return;

              await Navigator.popAndPushNamed(context, '/list');
            },
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/calendar') return;

              await Navigator.popAndPushNamed(context, '/calendar');
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            )),
      ],
    );
  }
}
