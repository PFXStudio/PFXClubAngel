import 'package:flutter/material.dart';

class GalleryItem {
  GalleryItem({this.id, this.resource});

  final String id;
  final String resource;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: galleryExampleItem.id,
            child: Image.asset(galleryExampleItem.resource, height: 80.0),
          ),
        ));
  }
}
