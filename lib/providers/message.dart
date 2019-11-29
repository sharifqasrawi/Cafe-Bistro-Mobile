import 'package:flutter/foundation.dart';

class Message with ChangeNotifier {
  final int id;
  final String name;
  final String email;
  final String subject;
  final String text;
  final DateTime createdAt;
  final bool isSeen;

  Message({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.subject,
    @required this.text,
    @required this.createdAt,
    this.isSeen
  });
}
