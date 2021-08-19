import 'package:flutter/material.dart';
import 'package:movenet_platform/constant/app_constants.dart';
import 'package:movenet_platform/util/helper_functions.dart';
import 'package:movenet_platform/view/native_camera_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _model;

  loadModel() async {
    bool? res;
    switch (_model) {
      case MOVENET_LIGHTING:
        res = await HelperFunctions.loadModel(model: _model!);
        print("Model: $MOVENET_LIGHTING");
        break;

      case MOVENET_THUNDER:
        res = await HelperFunctions.loadModel(model: _model!);
        print("Model: $MOVENET_THUNDER");
        break;
    }

    if(res!){
      print("Model successfully loaded");
    }
  }


  modelSelectionCallBack(model) {
    setState(() {
      _model = model;
    });

    loadModel();

    HelperFunctions.startNativeCameraActivity();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => modelSelectionCallBack(MOVENET_LIGHTING),
                child: Text("MoveNet Lighting"),
              ),
              ElevatedButton(
                onPressed: () => modelSelectionCallBack(MOVENET_THUNDER),
                child: Text("MoveNet Thunder"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
