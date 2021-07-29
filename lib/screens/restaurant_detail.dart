import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mealsApp/widgets/restaurant_carousel_image_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/loading_indicator.dart';
import '../models/restaurant.dart';
import '../widgets/custom_restaurant_sliver_appbar.dart';
import '../utils/constants.dart';
import '../extensions/capitalize_word_ext.dart';
import '../extensions/trim_whiteSpace_ext.dart';
import 'sliding_up_widget.dart';

class RestaurantDetail extends StatefulWidget {
  final Restaurant restaurantData;

  const RestaurantDetail({
    this.restaurantData,
  });

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  ScrollController _scrollController;

  final TextStyle kRestaurantDetailTextStyle = kListTileTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    color: kDarkBodyFontColor,
  );

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        panelController.expand();
      } else if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgs = widget.restaurantData.images.cast<String>();
    return Stack(
      children: [
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSliverAppBar(
                imageURL: widget.restaurantData.imageURL,
                imageFit: BoxFit.fitWidth,
                id: widget.restaurantData.id,
              ),
              SliverFillRemaining(
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  slidingBeginOffset: const Offset(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: kSmallSpaceUnits,
                      left: kMediumSpaceUnits,
                      right: kSmallSpaceUnits,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurantData.name,
                          style: kRestaurantDetailPageHeaderStyle.copyWith(
                              fontSize: kTitleHeadingFontSize),
                        ),
                        kSmallSizedBoxWidget,
                        _locationAndContactInfo(),
                        kSizedBoxWidget,
                        Expanded(
                          child: _overviewAndPhotos(context, imgs),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SlidingUpScreenWidget(
          isCarouselImages: true,
          panelController: panelController,
          slidingUpWidgetContent: restaurantImagesCarouselSlider(
            context,
            restaurantMealSamplesImages: imgs,
          ),
        ),
      ],
    );
  }

  Column _overviewAndPhotos(BuildContext context, List<String> imgs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kInfo,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: kHeadingColor,
                  fontSize: kSubHeaderFontSize,
                ),
          ),
          Text(
            widget.restaurantData.overview,
            style: kListTileTextStyle.copyWith(
              fontSize: kBody1FontSize,
              height: 1.8,
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.restaurantData.images?.length ?? 0,
              itemBuilder: (context, index) => _buildGridImage(imgs, index),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: kSmallSpaceUnits,
                mainAxisSpacing: kSmallSpaceUnits,
              ),
            ),
          ),
        ],
      );

  Column _locationAndContactInfo() {
    const kSizedBox = const SizedBox(height: 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(kLocation, style: kRestaurantDetailTextStyle),
            kSmallSizedBoxWidget,
            _getListDataAndReturnWidget(widget.restaurantData.city)
          ],
        ),
        kSizedBox,
        Text(kAddress, style: kRestaurantDetailTextStyle),
        kSmallSizedBoxWidget,
        _buildCityOrPhoneWidget(
          textOne: widget.restaurantData.address?.blantyreAddress,
          textTwo: widget.restaurantData.address?.lilongweAddress,
        ),
        kSizedBox,
        Text(kPhone, style: kRestaurantDetailTextStyle),
        _buildPhoneWidget(
          textOne: widget.restaurantData.phoneNumber?.blantyrePhoneNumber,
          textTwo: widget.restaurantData.phoneNumber?.lilongwePhoneNumber,
        ),
      ],
    );
  }

  Container _buildGridImage(List<String> imgs, int index) {
    const double dimension = 40.0;

    return Container(
      width: dimension,
      height: dimension,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Container(
        width: dimension,
        height: dimension,
        child: GestureDetector(
          onTap: () => panelController.expand(),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imgs[index].stripWhiteSpace(),
            placeholder: (context, _) => LoadingIndicatorWidget(
              size: MediaQuery.of(context).size,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getListDataAndReturnWidget(List<dynamic> city) {
    Widget cityWidget;

    if (city.length > 1) {
      cityWidget = _buildTextWidget(textOne: city[0], textTwo: city[1]);
    } else {
      cityWidget = _buildTextWidget(textOne: city[0]);
    }
    return cityWidget;
  }

  Text _buildTextWidget({@required String textOne, String textTwo = ''}) {
    var textValue;
    if (textTwo.isNotEmpty) {
      textValue = '${textOne.sentenceCase()} and ${textTwo.sentenceCase()}';
    } else {
      textValue = '${textOne.sentenceCase()}';
    }
    return Text(
      textValue,
      style: kListTileTextStyle,
    );
  }

  Widget _buildCityOrPhoneWidget({String textOne, String textTwo}) {
    if (textOne.isNotEmpty && textTwo.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextWidget(textOne: "BT: $textOne"),
          _buildTextWidget(textOne: "LL: $textTwo"),
        ],
      );
    } else {
      return textOne.isNotEmpty
          ? _buildTextWidget(textOne: "BT: $textOne")
          : _buildTextWidget(textOne: "LL: $textTwo");
    }
  }

  Widget _buildPhoneWidget({String textOne, String textTwo}) {
    if (textOne.isNotEmpty && textTwo.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCallWidget("BT: $textOne"),
          _buildCallWidget("LL: $textTwo"),
        ],
      );
    } else {
      return textOne.isNotEmpty
          ? _buildCallWidget("BT: $textOne")
          : _buildCallWidget("LL: $textTwo");
    }
  }

  Row _buildCallWidget(String phoneNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        _buildTextWidget(textOne: phoneNumber),
        IconButton(
          onPressed: () async {
            launch("tel://$phoneNumber");
          },
          icon: Icon(
            Icons.call,
            size: 18.0,
            color: kBoldOrangeColor,
          ),
        ),
        Text(
          '(call)',
          style: kListTileTextStyle,
        ),
      ],
    );
  }
}
