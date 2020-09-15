import 'package:cached_network_image/cached_network_image.dart';
import 'package:customphotoview/single_fullscreen_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:preload_page_view/preload_page_view.dart';

class FullscreenImageList extends StatefulWidget {
  List<String> photoList;

  FullscreenImageList({
    Key key,
    this.photoList,
  }) : super(key: key);

  @override
  _FullscreenImageListState createState() => _FullscreenImageListState();
}

class _FullscreenImageListState extends State<FullscreenImageList> {
  bool showMenu = false;
  bool zoomed = false;

  @override
  void initState() {
    super.initState();
    showMenu = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingeFullscreenPhoto(
      imageList: widget.photoList,
    );
  }

}

