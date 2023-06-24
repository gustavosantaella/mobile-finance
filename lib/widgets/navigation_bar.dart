import 'package:flutter/material.dart';
import 'package:wafi/helpers/fn/main.dart';

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
              await route(context, '/loans');
            },
            icon: const Icon(
              Icons.article,
              color: Colors.white,
            )),
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
              if (ModalRoute.of(context)?.settings.name == '/home') return;

              await Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.home, color: Colors.white)),
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

AppBar appBarWidget(String title, {String? subTitle}) => AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.w500,
                fontSize: 24),
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
