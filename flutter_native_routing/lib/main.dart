import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_routing/profile_view.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

const MethodChannel channel = MethodChannel("channel");

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "homeView",
      routes: {
        'homeView': (context) => HomeView(),
        'profileView': (context) => ProfileView()
      },
      title: 'Material App',
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: NativeDeviceOrientationReader(
          useSensor: true,
          builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('HomeView Screen'),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("route to PoseActivity");
                            await channel.invokeMethod(
                                "intentTo", "poseActivity");
                          },
                          child: FittedBox(child: Text("PoseActivity")),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("route to CameraActivity");
                            await channel.invokeMethod(
                                "intentTo", "cameraActivity");
                          },
                          child: FittedBox(child: Text("CameraActivity")),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("route to ProfileView");
                            await Navigator.of(context)
                                .pushNamed("profileView");
                          },
                          child: FittedBox(child: const Text("ProfileView")),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
