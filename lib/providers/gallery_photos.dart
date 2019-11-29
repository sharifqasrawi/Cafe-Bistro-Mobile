import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './gallery_photo.dart';

class GalleryPhotos with ChangeNotifier {
  List<GalleryPhoto> _photos;

  List<GalleryPhoto> get photos {
    return [..._photos];
  }

  Future<void> fetchAndSetCategories() async {
    final url = Uri.http('10.0.2.2:8000', '/api/api-gallery');

    final response = await http.get(url);

    final extractedData = json.decode(response.body) as List<dynamic>;

    List<GalleryPhoto> loadedPhotos = [];

    extractedData.forEach((data) {
      loadedPhotos.add(
        GalleryPhoto(
          id: data['id'],
          title: data['_title'],
          imageUrl: data['_image'] == null
              ? ''
              : Uri.http('10.0.2.2:8000',
                      '/assets/images/uploads/' + data['_image'])
                  .toString(),
        ),
      );
    });
    
    _photos = loadedPhotos;

    notifyListeners();
  }
}
