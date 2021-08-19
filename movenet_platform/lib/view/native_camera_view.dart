import 'package:flutter/material.dart';
import 'package:movenet_platform/util/helper_functions.dart';

class NativeCameraView extends StatefulWidget {
  const NativeCameraView({Key? key}) : super(key: key);

  @override
  _NativeCameraViewState createState() => _NativeCameraViewState();
}

class _NativeCameraViewState extends State<NativeCameraView> {
  @override
  void initState() {
    super.initState();

    startActivity();
  }

  startActivity() async{
    await HelperFunctions.startNativeCameraActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
    );
  }
}
