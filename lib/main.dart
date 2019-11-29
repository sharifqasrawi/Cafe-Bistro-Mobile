import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './providers/system_settings.dart';
import './screens/contactus_screen.dart';
import './providers/messages.dart';
import './screens/menu_screen.dart';
import './providers/menus.dart';
import './screens/item_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/gallery_screen.dart';
import './providers/gallery_photos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SystemSettings(),
        ),
        ChangeNotifierProvider.value(
          value: Messages(),
        ),
        ChangeNotifierProvider.value(
          value: Menus(),
        ),
         ChangeNotifierProvider.value(
          value: GalleryPhotos(),
        ),
      ],
      child: MaterialApp(
        title: 'Cafe La fontaine',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo,
          accentColor: Colors.grey,
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        home: TabsScreen(),
        routes: {
          ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
          MenuScreen.routeName: (ctx) => MenuScreen(),
          ItemDetailsScreen.routeName: (ctx) => ItemDetailsScreen(),
          GalleryScreen.routeName: (ctx) => GalleryScreen(),
        },
      ),
    );
  }
}
