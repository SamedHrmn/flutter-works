import 'package:flutter/material.dart';

import 'view/jsonplaceholder_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Material App', home: JsonPlaceHolderView());
  }
}
