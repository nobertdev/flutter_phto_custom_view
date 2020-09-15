import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_advanced_networkimage/zoomable.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SingeFullscreenPhoto extends StatefulWidget {
  const SingeFullscreenPhoto({
    Key key,
    //@required this.photo,
    @required this.imageList,
  }) : super(key: key);

  //final String photo;
  //final Function(double value) onZoomChanged;
  final List<String> imageList;

  @override
  _SingeFullscreenPhotoState createState() => _SingeFullscreenPhotoState();
}

class _SingeFullscreenPhotoState extends State<SingeFullscreenPhoto>
    with TickerProviderStateMixin {
  bool _showMenu = true;
  AnimationController opacityController;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    opacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    opacity =
        CurvedAnimation(parent: opacityController, curve: Curves.easeInOut);
    opacityController.forward();
    //_showMenu = widget.showMenu;


  }

  @override
  void didUpdateWidget(SingeFullscreenPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      //_showMenu = widget.showMenu;
    });
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<
                  AllowMultipleGestureRecognizer>(
                    () => AllowMultipleGestureRecognizer(),  //constructor
                    (AllowMultipleGestureRecognizer instance) {
                  instance.onTap = () {
                    //print('Episode 8 is best! (nested container)');
                    setState(() {
                      _showMenu = !_showMenu;
                    });
                  };
                },
              )
            },
            //Creates the nested container within the first.

            child: Center(
              child: _futurePages(widget.imageList),
            ),
          ),
          _showMenu? buildOverlayMenu(context): Container()
        ]
    );
  }

  Widget buildOverlayMenu(BuildContext context) {
    return FadeTransition(
        opacity: opacity,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.only(
                    bottom: 5, top: 5, left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => Navigator.of(context).pop()),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.only(
                    bottom: 5, top: 5, left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.favorite,
                              color:
                              Colors.red
                          ),
                          Text("12"),
                          SizedBox(width: 5),
                          Icon(Icons.sms,
                              color: Colors.white),
                          Text("23"),
                          SizedBox(width: 5),
                        ]),
                    FlatButton.icon(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        onPressed: () {},
                        icon: Icon(Icons.crop_free,
                            color: Colors.white),
                        label: Text(
                          "user 123",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              )
            ]));
  }

  Future<List<CachedNetworkImageProvider>> _loadAllImages(List<String> imageUrlList) async {
    List<CachedNetworkImageProvider> cachedImages = [];

    if (imageUrlList == null) {
      return cachedImages;
    }

    for(int i=0;i<imageUrlList.length;i++) {
      var configuration = createLocalImageConfiguration(context);
      cachedImages.add(new CachedNetworkImageProvider(imageUrlList[i])..resolve(configuration));
    }
    return cachedImages;
  }

  FutureBuilder<List<CachedNetworkImageProvider>> _futurePages(List<String> imageUrlList) {
    return new FutureBuilder(
      future: _loadAllImages(imageUrlList),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData) {
          return Container(
            child: PhotoViewGallery.builder(
              itemCount: imageUrlList.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: snapshot.data[index],
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  onTapDown: (value1,value2,value3){
                    setState(() {
                      _showMenu = !_showMenu;
                    });
                  }
                );
              },
              scrollPhysics: ClampingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),

            ),
          );
        } else if(!snapshot.hasData) {
          return new Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {

  @override

  void rejectGesture(int pointer) {

    acceptGesture(pointer);

  }

}
