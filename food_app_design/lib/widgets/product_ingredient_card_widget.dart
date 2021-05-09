import 'package:flutter/material.dart';

import '../components/single_child_card_container.dart';

class ProductIngredientCardWidget extends StatelessWidget {
  final String imagePath;

  const ProductIngredientCardWidget({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainerSingleChild(
      widget: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
