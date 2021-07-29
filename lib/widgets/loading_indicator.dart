import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Size size;
  const LoadingIndicatorWidget({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatedSize =
        size.width < size.height ? size.width / 3 : size.height / 3;
    return Center(
      child: SizedBox(
        width: calculatedSize,
        height: calculatedSize,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          color: Colors.green[200],
        ),
      ),
    );
  }
}
