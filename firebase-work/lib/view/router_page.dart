import 'package:flutter/material.dart';

import '../service/firebase_auth_service.dart';
import '../utils/locator.dart';
import 'login_page.dart';
import 'register_page.dart';

class RouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (getIt<FirebaseAuthService>().firebaseAuthService.currentUser == null) {
      return RegisterPage();
    }
    return LoginPage();
  }
}
