import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/system_settings.dart';

class AboutusScreen extends StatefulWidget {
  static const routeName = '/about-us';

  @override
  _AboutusScreenState createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  var aboutusText = '';
  var aboutUsImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SystemSettings>(context, listen: false)
          .fetchAndSetSystemSettings(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            return Center(
              child: Text(
                'Error loading data',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            );
          } else {
            aboutusText =
                Provider.of<SystemSettings>(context).systemSettings.aboutUsText;

            aboutUsImageUrl = Provider.of<SystemSettings>(context)
                .systemSettings
                .aboutUsImageUrl;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Image.network(
                      aboutUsImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.black26,
                        padding: const EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: SingleChildScrollView(
                          child: Card(
                            elevation: 5,
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                aboutusText,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
