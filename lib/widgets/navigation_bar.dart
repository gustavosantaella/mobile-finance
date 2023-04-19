import 'package:finance/config/constanst.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: definitions['colors']['background']['app'],
      destinations: [
        IconButton(
            onPressed: () async {
              await Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.home, color: Colors.white)),
        IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/calendar') return;

              await Navigator.pushNamed(context, '/calendar');
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            )),
            IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/calendar') return;

              await Navigator.pushNamed(context, '/calendar');
            },
            icon: const Icon(
              Icons.graphic_eq,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () async {
              if (ModalRoute.of(context)?.settings.name == '/calendar') return;

              await Navigator.pushNamed(context, '/calendar');
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ))
      ],
    );
  }
}
