import 'package:customphotoview/single_fullscreen_photo.dart';
import 'package:flutter/material.dart';

import 'fullscreen_image_list.dart';

class ImageDialog extends ModalRoute<void> {
  final List<String> photoList;
  bool showMenu = false;
  bool zoomed = false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  ImageDialog(this.photoList);

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: FullscreenImageList(
          //onZoomChanged: (value) => setState(() => zoomed = value != 1.0),
          photoList: photoList,
          //onShowMenu: (bool shown) => setState(() => showMenu = shown)
        )
      ),
    );
  }
}