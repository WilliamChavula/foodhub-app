import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

class SlidingUpScreenWidget extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final Widget slidingUpWidgetContent;
  final bool isCarouselImages;
  final TextEditingController editingController;

  const SlidingUpScreenWidget({
    @required this.panelController,
    this.slidingUpWidgetContent,
    this.isCarouselImages = false,
    this.editingController,
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

    const Radius kRadius = Radius.circular(10.0);

    return SlidingUpPanelWidget(
      child: Container(
        decoration: ShapeDecoration(
          color: _color,
          shadows: [
            BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
                color: const Color(0x80000000))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: kRadius,
              topRight: kRadius,
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
                onPressed: () {
                  panelController.hide();
                  FocusScope.of(context).unfocus();
                  widget.editingController?.clear();
                },
              ),
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: widget.slidingUpWidgetContent,
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      controlHeight: 0.0,
      anchor: 0.4,
      panelController: panelController,
      dragStart: (_) => FocusScope.of(context).unfocus(),
      //Pass a onTap callback to customize the processing logic when user click control bar.
      enableOnTap: false,
    );
  }
}
