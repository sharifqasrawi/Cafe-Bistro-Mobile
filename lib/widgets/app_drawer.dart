import 'package:flutter/material.dart';

import '../screens/contactus_screen.dart';
import '../screens/menu_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            AppBar(
              title: Text('Cafe La Fontaine'),
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(100, 100, 100, 1),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Menu'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(MenuScreen.routeName);
              },
            ),
            Divider(),
            AboutListTile(
              applicationName: 'Cafe',
              applicationLegalese: 'Developed by Sharif Qasrawi',
              icon: Icon(Icons.info),
              applicationVersion: '1.0.0',
            ),
          ],
        ),
      ),
    );
  }
}
