import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.blue,
      destinations: [
        IconButton(
            onPressed: () async {
              print(ModalRoute.of(context)?.settings.name);
              await Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.home, color: Colors.white)),
        IconButton(
            onPressed: () async {
              print(ModalRoute.of(context)?.settings.name);
              if (ModalRoute.of(context)?.settings.name == '/calendar') return;

              await Navigator.popAndPushNamed(context, '/calendar');
              print("im back");
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ))
      ],
    );
  }
}
