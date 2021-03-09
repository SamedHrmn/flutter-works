import 'package:firebase_work/form_screen.dart';
import 'package:firebase_work/service/firebase_auth_service.dart';
import 'package:firebase_work/utils/locator.dart';
import 'package:firebase_work/view/login_page.dart';
import 'package:firebase_work/view/register_page.dart';

import 'package:flutter/material.dart';

class RouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (getIt<FirebaseAuthService>().firebaseAuthService.currentUser == null) {
      return RegisterPage();
    }
    return LoginPage();
  }
}
