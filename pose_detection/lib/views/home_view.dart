import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pose_detection/constants/asset_constants.dart';
import 'package:tflite/tflite.dart';
import 'package:pose_detection/widgets/app_camera.dart';
import 'package:pose_detection/widgets/bounded_box.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model;

  @override
  void initState() {
    super.initState();

    loadModel();
  }

  loadModel() async {
    String model = await Tflite.loadModel(model: AssetConstants.POSE_MODEL_TFLITE);
    setState(() {
      _model = model;
    });
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _model == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                AppCamera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BoundedBox(_recognitions == null ? [] : _recognitions, math.max(_imageHeight, _imageWidth), math.min(_imageHeight, _imageWidth),
                    MediaQuery.of(context).size.height, MediaQuery.of(context).size.width, _model),
              ],
            ),
    );
  }
}
