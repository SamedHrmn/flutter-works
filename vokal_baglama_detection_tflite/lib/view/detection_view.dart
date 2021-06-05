import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite_audio/tflite_audio.dart';

import '../constant/asset_constant.dart';

class DetectionView extends StatefulWidget {
  const DetectionView({Key key}) : super(key: key);

  @override
  _DetectionViewState createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  String _sound = "Start detection!";
  bool _recording = false;
  Stream<Map<dynamic, dynamic>> result;
  String recognition = "";

  @override
  void initState() {
    super.initState();

    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: buildPageTitle()),
            Expanded(flex: 4, child: buildHeadingLottie()),
            Expanded(child: buildControlButtons()),
            Visibility(visible: _recording, child: Expanded(child: buildRecordingLottie())),
            Expanded(flex: 2, child: buildDetectionClassText()),
          ],
        ),
      ),
    );
  }

  buildPageTitle() {
    return Container(
      padding: EdgeInsets.all(20),
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: Text(
          "Bağlama & Vokal \nClassifier",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 42, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
    );
  }

  buildHeadingLottie() {
    return Row(
      children: [
        Spacer(),
        Expanded(flex: 4, child: Lottie.asset(AssetConstant.LOTTIE_BACKGROUND)),
        Flexible(
            child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text("Samed Harman"),
            ),
          ),
        )),
      ],
    );
  }

  buildControlButtons() {
    return _recording
        ? MaterialButton(
            onPressed: stopRecorder,
            textColor: Colors.white,
            color: Colors.pink,
            child: Icon(Icons.stop, size: 36),
            shape: CircleBorder(),
          )
        : MaterialButton(
            onPressed: _recorder,
            color: Colors.pink,
            textColor: Colors.white,
            child: Icon(Icons.mic, size: 36),
            shape: CircleBorder(),
          );
  }

  buildRecordingLottie() {
    return Lottie.asset(AssetConstant.LOTTIE_RECORDING);
  }

  buildDetectionClassText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Text(
        '$_sound',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
      ),
    );
  }

  void loadModel() {
    TfliteAudio.loadModel(
      model: AssetConstant.TFLITE_MODEL,
      label: AssetConstant.TFLITE_LABEL,
      numThreads: 1,
      isAsset: true,
    );
  }

  stopRecorder() {
    TfliteAudio.stopAudioRecognition();
    setState(() {
      _recording = false;
      _sound = "Start detection!";
    });
  }

  _recorder() {
    setState(() {
      _recording = true;
    });

    if (_recording) {
      result = TfliteAudio.startAudioRecognition(
        numOfInferences: 300,
        inputType: 'rawAudio',
        sampleRate: 44100,
        recordingLength: 44032,
        bufferSize: 22016,
        detectionThreshold: 0.7,
      );
      result.listen((event) {
        if (event != null) {
          recognition = event["recognitionResult"];
          setState(() {
            _sound = recognition.split(" ")[1];
          });
        }
      }).onDone(() {
        setState(() {
          _recording = false;
        });
      });
    }
  }
}
