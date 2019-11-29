import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/gallery_photo.dart';
import '../providers/gallery_photos.dart';
import '../widgets/gallery_item.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<GalleryPhoto> photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        backgroundColor: Color.fromRGBO(100, 100, 100, 1),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black54,
            child: FutureBuilder(
              future: Provider.of<GalleryPhotos>(context, listen: false)
                  .fetchAndSetCategories(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return Center(
                      child: Text(
                        'Error loading data',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    );
                  } else {
                    photos = Provider.of<GalleryPhotos>(context, listen: false)
                        .photos;
                    return ListView.builder(
                      itemCount: photos.length,
                      itemBuilder: (ctx, idx) => GalleryItem(photos[idx]),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
