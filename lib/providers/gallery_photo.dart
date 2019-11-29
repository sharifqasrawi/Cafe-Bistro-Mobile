import 'package:flutter/foundation.dart';

class GalleryPhoto with ChangeNotifier {
  final int id;
  final String imageUrl;
  final String title;

  GalleryPhoto({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
  });
}
