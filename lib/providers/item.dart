import 'package:flutter/foundation.dart';

import './comment.dart';

class Item with ChangeNotifier{
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  List<Comment> comments = [];

  Item({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });
}