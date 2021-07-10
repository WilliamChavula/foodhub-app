import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// import 'loading_indicator.dart';

class SlidingUpScreenWidget extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final Widget slidingUpWidgetContent;
  final bool isCarouselImages;

  const SlidingUpScreenWidget({
    @required this.panelController,
    this.slidingUpWidgetContent,
    this.isCarouselImages = false,
  });

  @override
  _SlidingUpScreenWidgetState createState() => _SlidingUpScreenWidgetState();
}

class _SlidingUpScreenWidgetState extends State<SlidingUpScreenWidget> {
  SlidingUpPanelController panelController;

  @override
  void initState() {
    panelController = widget.panelController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _color =
        widget.isCarouselImages ? Colors.black.withOpacity(0.8) : Colors.white;
    return SlidingUpPanelWidget(
      child: Container(
        decoration: ShapeDecoration(
          color: _color,
          shadows: [
            BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
                color: const Color(0x11000000))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: _color,
              alignment: Alignment.topLeft,
              height: 50.0,
              child: IconButton(
                color: widget.isCarouselImages ? Colors.white : Colors.black,
                icon: Icon(Icons.close),
                onPressed: () => panelController.hide(),
              ),
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 20.0,
            ),

            /// TODO: Put carousel image slider here
            widget.slidingUpWidgetContent,
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      controlHeight: 0.0,
      anchor: 0.4,
      panelController: panelController,
      onTap: () {
        ///Customize the processing logic
        if (SlidingUpPanelStatus.expanded == panelController.status) {
          panelController.hide();
        } else {
          panelController.expand();
        }
      }, //Pass a onTap callback to customize the processing logic when user click control bar.
      enableOnTap: true,
    );
  }
}
