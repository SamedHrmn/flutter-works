import 'package:flutter/services.dart';
import 'package:movenet_platform/constant/app_constants.dart';

class HelperFunctions {
  static MethodChannel _methodChannel = MethodChannel("channel");

  static Future<dynamic> loadModel({required String model}) async {
    String? param;

    switch (model) {
      case MOVENET_LIGHTING:
        param = "movenet_lightning";
        break;
      case MOVENET_THUNDER:
        param = "movenet_thunder";
        break;
    }

    return await _methodChannel.invokeMethod('loadModel', {"model": param});
  }

  static Future<void> startNativeCameraActivity() async{
    bool response = await _methodChannel.invokeMethod('startNativeCameraActivity');
    if(response){
      print("Camera Activity Started");
    }
  }

}
