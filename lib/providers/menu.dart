import 'package:flutter/foundation.dart';

import './item.dart';

class Menu with ChangeNotifier {
  final int id;
  final String title;
  List<Item> items = [];

  Menu({
    @required this.id,
    @required this.title,
  });
}
