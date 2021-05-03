import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({
    Key key,
  }) : super(key: key);

  static const platformChannel = MethodChannel('notification');

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Platform Channel - Kotlin Android',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    _response ?? "Waited for service",
                    style: Theme.of(context).textTheme.bodyText2,
                  ))),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Show Notification"),
                      onPressed: showNotification,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Remove Notification"),
                      onPressed: removeNotification,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showNotification() async {
    var response =
        await MyHome.platformChannel.invokeMethod('showNotification');
    setState(() {
      _response = response;
    });
  }

  removeNotification() async {
    var response =
        await MyHome.platformChannel.invokeMethod('removeNotification');
    setState(() {
      _response = response;
    });
  }
}
