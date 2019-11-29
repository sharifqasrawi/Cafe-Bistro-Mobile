import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './item.dart';
import './menu.dart';
import './comment.dart';

class Menus with ChangeNotifier {
  List<Menu> _categories = [];
  List<Item> _items = [];
  List<Comment> _comments = [];

  List<Menu> get categories {
    return [..._categories];
  }

  List<Item> get items {
    return [..._items];
  }

  
  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true,
    );
    return htmlText.replaceAll(exp, '');
  }


  Future<void> fetchAndSetCategories() async {
    final url = Uri.http('10.0.2.2:8000', '/api/api-menu');

    final response = await http.get(url);

    final extractedData = json.decode(response.body) as List<dynamic>;

    final List<Menu> loadedCategories = [];

    extractedData.forEach(
      (data) {
        final items = data['_items'] as List<dynamic>;

        final menu = Menu(
          id: data['id'],
          title: data['_title'],
        );

        items.forEach((i) {
          final item = Item(
            id: i['id'],
            title: i['_title'],
            description: removeHtmlTags(i['_description']),
            price: i['_price'],
            imageUrl: i['_image'] == null
                ? ''
                : Uri.http('10.0.2.2:8000',
                        '/assets/images/uploads/' + i['_image'])
                    .toString(),
          );

          final comments = i['comments'] as List<dynamic>;

          comments.forEach((c) {
            final comment = Comment(
              id: c['id'],
              text: c['_text'],
              name: c['_user_name'],
              email: '',
              itemId: item.id,
              createdAt: DateTime.parse(
                c['_created_at'],
              ),
            );
            item.comments.add(comment);
            item.comments = item.comments.reversed.toList();
            _comments.add(comment);
            _comments = _comments.reversed.toList();
          });

          _items.add(item);

          menu.items.add(item);
        });

        loadedCategories.add(menu);
      },
    );

    _categories = loadedCategories;

    notifyListeners();
  }

  Future<void> postComment(Comment comment) async {
    try {
      final url = Uri.http('10.0.2.2:8000', '/api/comment');
      await http.post(
        url,
        body: json.encode(
          {
            'itemId': comment.itemId,
            'name': comment.name,
            'email': comment.email,
            'text': comment.text,
            'createdAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      final item = getItem(comment.itemId);
      item.comments.add(comment);
      item.comments = item.comments.reversed.toList();

      // print(response.body);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Item getItem(int id) {
    return _items.firstWhere((i) => i.id == id, orElse: () => null);
  }
}
