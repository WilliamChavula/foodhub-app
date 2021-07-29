import 'dart:core';

import 'package:flutter/material.dart';

const kRestaurantDetailPageTileHeaderStyle = TextStyle(
  color: kBoldOrangeColor,
  fontSize: kSubHeaderFontSize,
  fontWeight: FontWeight.w500,
);

const kBackgroundColorStyle = Color(0XFFf5f6fa);

const kRestaurantDetailPageHeaderStyle = TextStyle(
  fontSize: kH1HeadingFontSize,
  fontFamily: 'Oxygen',
  fontWeight: FontWeight.w700,
  color: kHeadingColor,
);

const kListTileTextStyle = TextStyle(
  fontSize: kBody1FontSize,
  color: kBodyFontColor,
);

const kAppSelectedIconStyle = Color(0XFFe84118);

const kAppUnselectedIconStyle = Color(0XFF7f8fa6);

const kAppSplashColor = Color(0X30273c75);

// Colors

/// Bold orange for color gradient
const kBoldOrangeColor = const Color(0XFFE8393C);

/// Bold orange for color gradient
const kMidOrangeColor = const Color(0XFFEF4D41);

/// Bold orange for color gradient
const kLightOrangeColor = const Color(0XFFFF6847);

/// Heading 1 and Heading 2 color
const kHeadingColor = const Color(0XFF303030);

/// Body 1 font color
const kBodyFontColor = const Color(0XFFA3A3A3);

/// Body 2 font color
const kDarkBodyFontColor = const Color(0XFF666666);

/// accent color for input border and input icon
const kAccentColor = const Color(0XFFA3434F);

/// scaffold widget background color
const kScaffoldColor = const Color(0XFFFBFBFB);

/// Icon Container background color
/// A subtle grey color for back_icon on [MealDetailPage] and [RestaurantDetailPage]
const kIconBackgroundColor = const Color(0XFFB4B2BD);

const kImageGradientColor1 = Colors.transparent;
const kImageGradientColor2 = Colors.black26;
const kImageGradientColor3 = Colors.black54;

/// shadow color for search FAB
const kShadowColor = const Color(0XFFF4F4F4);

// Font sizes
/// [size = 36.0]
const double kH1HeadingFontSize = 34.0;

/// [size = 28.0]
const double kTitleHeadingFontSize = 28.0;

/// [size = 18.0]
const double kSubHeaderFontSize = 18.0;

/// [size = 16.0]
const double kBody2FontSize = 16.0;

/// [size = 14.0]
const double kBody1FontSize = 14.0;

// Padding and Margin

const double kSmallSpaceUnits = 8.0;

/// unit of spacing. For example [padding = 8.0] or [margin = 8.0]
const EdgeInsets kSmallPadding = const EdgeInsets.all(kSmallSpaceUnits);

const double kMediumSpaceUnits = 10.0;

/// unit of spacing. For example [padding = 10.0] or [margin = 10.0]
const EdgeInsets kMediumPadding = const EdgeInsets.all(kMediumSpaceUnits);

const double kLargeSpaceUnits = 16.0;

/// unit of spacing. For example [padding = 16.0] or [margin = 16.0]
const EdgeInsets kLargePadding = const EdgeInsets.all(kLargeSpaceUnits);

/// space units for [SizedBox = 16.0]
const double kSizedBoxUnits = 16.0;
const SizedBox kSizedBoxWidget = const SizedBox(height: kSizedBoxUnits);

/// space units for [SizedBox = 8.0]
const double kSmallSizedBoxUnits = 8.0;
const SizedBox kSmallSizedBoxWidget =
    const SizedBox(height: kSmallSizedBoxUnits);

/// Border Radius [Radius = 15.0]
final BorderRadius kBorderRadius = BorderRadius.circular(15.0);

// constant strings
const String kAppTitle = "TIDYE";
const String kAppSlogan = "Discover Malawi's finest cuisine..Kalibu!";

const String kInfo = "Info";

const String kLocation = "Location: ";
const String kAddress = "Address: ";
const String kPhone = "Phone: ";
const String kSearchHintText = "Search by Restaurant name...";
const String kAppName = "Tidye";
