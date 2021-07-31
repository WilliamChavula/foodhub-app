import 'package:flutter/material.dart';
import 'package:mealsApp/utils/constants.dart';
import '../utils/constants.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  const ErrorScreen({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kMediumSpaceUnits, vertical: kMediumSpaceUnits),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/service_unavailable.png',
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: kMediumSpaceUnits,
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: kListTileTextStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: kSubHeaderFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
