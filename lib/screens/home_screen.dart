import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/menus.dart';
import '../providers/system_setting.dart';
import '../providers/system_settings.dart';
import './gallery_screen.dart';
import './menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  SystemSetting systemSettings;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<SystemSettings>(context)
          .fetchAndSetSystemSettings()
          .then((_) {
        systemSettings = Provider.of<SystemSettings>(context).systemSettings;
        setState(() {
          _isLoading = false;
        });
      });

      Provider.of<Menus>(context).fetchAndSetCategories();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.black45,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(
                          systemSettings.logoUrl,
                          width: 200,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: RefreshIndicator(
                          onRefresh: Provider.of<SystemSettings>(context)
                              .fetchAndSetSystemSettings,
                          child: Column(
                            children: <Widget>[
                              Text(
                                systemSettings.appInfo,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                systemSettings.appInfo2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        child: GridView(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          children: <Widget>[
                            InkWell(
                              onTap: () => {
                                Navigator.of(context)
                                    .pushNamed(MenuScreen.routeName)
                              },
                              splashColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Center(
                                  child: Text(
                                    'Our Menu',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Color.fromRGBO(100, 100, 100, 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {
                                Navigator.of(context)
                                    .pushNamed(GalleryScreen.routeName)
                              },
                              splashColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Center(
                                  child: Text(
                                    'Photo Gallery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Color.fromRGBO(100, 100, 100, 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {},
                              splashColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Center(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        systemSettings.addressStreet,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        systemSettings.addressCity,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        systemSettings.addressCountry,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Color.fromRGBO(100, 100, 100, 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {},
                              splashColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Center(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '${systemSettings.phone}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${systemSettings.email}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Color.fromRGBO(100, 100, 100, 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
