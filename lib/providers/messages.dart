import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'message.dart';

class Messages with ChangeNotifier {
  Future<void> sendMessage(Message message) async {
    try {
      final url = Uri.http('10.0.2.2:8000', '/api/send-message');
       await http.post(
        url,
        body: json.encode(
          {
            'name': message.name,
            'email': message.email,
            'subject': message.subject,
            'text': message.text,
            'createdAt': DateTime.now().toIso8601String(),
            'isSeen': false,
          },
        ),
      );

      //print(response.body);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
