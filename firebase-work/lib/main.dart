import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/locator.dart';
import 'view/router_page.dart';
import 'view_model/motto_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MottoViewModel>(
      create: (_) => MottoViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RouterPage(),
      ),
    );
  }
}
