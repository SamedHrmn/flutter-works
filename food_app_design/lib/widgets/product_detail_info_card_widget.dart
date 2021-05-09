import 'package:flutter/material.dart';

import '../components/normal_card_container.dart';
import '../extensions/theme_extension.dart';

class ProductDetailInfoCardWidget extends StatelessWidget {
  final String assetImagePath;
  final String text;

  const ProductDetailInfoCardWidget({Key key, this.assetImagePath, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NormalCardContainer(
      elementFirst: Image.asset(
        assetImagePath,
        fit: BoxFit.cover,
      ),
      elementSecond: Text(
        text,
        style: context.textTheme.bodyText1,
      ),
    );
  }
}
