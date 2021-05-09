import 'package:flutter/material.dart';

import '../constants/asset_constants.dart';
import '../constants/string_constants.dart';
import '../extensions/size_extension.dart';

class ProductSliderItemWidget extends StatelessWidget {
  final String productName;
  final String productText;
  final String imagePath;
  final String priceText;

  const ProductSliderItemWidget({
    Key key,
    @required this.productName,
    @required this.productText,
    @required this.imagePath,
    @required this.priceText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.horizontalPaddingMedium,
      decoration: BoxDecoration(color: Colors.white, borderRadius: context.borderRadiusAllMedium),
      child: Column(
        children: [
          Expanded(flex: 8, child: Image.network(imagePath)),
          Flexible(
            child: Text(productName),
          ),
          Flexible(
            child: Text(productText),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(AssetConstants.ICON_PRODUCT_PATH + "flame.png"),
                ),
                Flexible(
                  child: Text("78 " + StringConstants.PRODUCT_CALORIE_STRING),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text("\$"),
                ),
                Flexible(
                  child: Text(
                    priceText,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
