import 'package:flutter/material.dart';
import 'package:mealsApp/utils/constants.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  const ErrorScreen({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/service_unavailable.png',
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: kListTileTextStyle.copyWith(
                fontWeight: FontWeight.w400, fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
