import 'package:flutter/material.dart';
import 'package:pose_detection/constants/asset_constants.dart';

class BoundedBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BoundedBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW, this.model);

  @override
  _BoundedBoxState createState() => _BoundedBoxState();
}

class _BoundedBoxState extends State<BoundedBox> {
  String _score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: renderKeypoints(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(_score != null ? _score : "0.0"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "P\nO\nS\nE\n\nD\nE\nT\nE\nC\nT\nI\nO\nN",
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  scoreValueCallback(value) {
    setState(() {
      _score = value;
    });
  }

  renderKeypoints() {
    var lists = <Widget>[];
    widget.results.forEach((re) {
      var list = re["keypoints"].values.map<Widget>((k) {
        if (k["part"] == "nose") scoreValueCallback(k["score"].toStringAsFixed(3));

        var _x = k["x"];
        var _y = k["y"];
        var scaleW, scaleH, x, y;

        if (widget.screenH / widget.screenW > widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          y = _y * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          y = (_y - difH / 2) * scaleH;
        }
        return Positioned(
          left: x + 40,
          top: y - 20,
          width: 100,
          height: 100,
          child: Container(
            decoration: k["part"] == "nose"
                ? BoxDecoration(image: DecorationImage(image: AssetImage(AssetConstants.EAR_IMAGE), fit: BoxFit.cover))
                : BoxDecoration(),
          ),
        );
      }).toList();
      lists..addAll(list);
    });

    return lists;
  }
}
