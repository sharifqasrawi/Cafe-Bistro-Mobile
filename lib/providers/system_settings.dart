import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'system_setting.dart';

class SystemSettings with ChangeNotifier {
  SystemSetting _systemSettings;

  SystemSetting get systemSettings {
    return _systemSettings;
  }

  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true,
    );
    return htmlText.replaceAll(exp, '');
  }

  Future<void> fetchAndSetSystemSettings() async {
    final url = Uri.http('10.0.2.2:8000', '/api/system');
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as List<dynamic>;

    var loadedSystemSettings;

    extractedData.forEach((data) {
      loadedSystemSettings = SystemSetting(
        id: data['id'],
        appName: data['_app_name'],
        appInfo: data['_app_info'],
        appInfo2: data['_app_info2'],
        logoUrl: data['_app_logo'] == null
            ? ''
            : Uri.http('10.0.2.2:8000',
                    '/assets/images/uploads/' + data['_app_logo'])
                .toString(),
        phone: data['_phone'],
        email: data['_email'],
        addressStreet: data['_address__street'],
        addressCity: data['_address__city'],
        addressCountry: data['_address__country'],
        aboutUsText: removeHtmlTags(data['_aboutus__text']),
        aboutUsImageUrl: data['_aboutus__image'] == null
            ? ''
            : Uri.http('10.0.2.2:8000',
                    '/assets/images/uploads/' + data['_aboutus__image'])
                .toString(),
        instagramLink: data['_instagram__link'],
        facebookLink: data['_facebook__link'],
        twitterLink: data['_instagram__link'],
        locationLng: data['location_longitude'],
        locationLat: data['location_latitude'],
      );
    });

    _systemSettings = loadedSystemSettings;
    notifyListeners();
  }

  Future<void> testpost() async {
    final url = Uri.http('10.0.2.2:8000', '/api/testpost');
    final response =
        await http.post(url, body: json.encode({'hello': 'world !!'}));

    print(response.body);

    notifyListeners();
  }
}
