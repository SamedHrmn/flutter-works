import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';

class NormalCardContainer extends StatelessWidget {
  final Widget elementFirst;
  final Widget elementSecond;

  const NormalCardContainer({Key key, this.elementFirst, this.elementSecond}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConstants.instance.valueLow),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.instance.navbarBackgroundColor),
        borderRadius: BorderRadius.circular(SizeConstants.instance.valueLow),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox.expand(
              child: FittedBox(
                child: elementFirst,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SizedBox.expand(
              child: FittedBox(
                child: elementSecond,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
