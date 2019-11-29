import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Comment with ChangeNotifier {
  final int id;
  final String name;
  final String email;
  final String text;
  final int itemId;
  final DateTime createdAt;

  Comment({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.itemId,
    @required this.text,
    @required this.createdAt,
  });


}
