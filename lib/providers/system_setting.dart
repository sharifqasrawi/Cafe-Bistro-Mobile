import 'package:flutter/foundation.dart';

class SystemSetting with ChangeNotifier {
  final int id;
  final String appName;
  final String appInfo;
  final String appInfo2;
  final String logoUrl;
  final String phone;
  final String email;
  final String addressStreet;
  final String addressCity;
  final String addressCountry;
  final String aboutUsText;
  final String aboutUsImageUrl;
  final String facebookLink;
  final String twitterLink;
  final String instagramLink;
  final double locationLng;
  final double locationLat;

  SystemSetting({
    @required this.id,
    @required this.appName,
    @required this.appInfo,
    @required this.appInfo2,
    @required this.logoUrl,
    @required this.phone,
    @required this.email,
    @required this.addressStreet,
    @required this.addressCity,
    @required this.addressCountry,
    @required this.aboutUsText,
    @required this.aboutUsImageUrl,
    @required this.facebookLink,
    @required this.instagramLink,
    @required this.twitterLink,
    @required this.locationLng,
    @required this.locationLat,
  });
}
