import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_work/model/motto_model.dart';
import 'package:firebase_work/service/firebase_auth_service.dart';
import 'package:firebase_work/service/firestore_service.dart';
import 'package:firebase_work/utils/locator.dart';

class Repository {
  final FirebaseAuthService? _firebaseAuthService = getIt<FirebaseAuthService>();
  final FireStoreService? _firestoreService = getIt<FireStoreService>();

  Future registerWithMail(String email, String password) async {
    var result = await _firebaseAuthService!.registerWithMail(email, password);
    return result;
  }

  Future loginWithMail(String email, String password) async {
    bool result = await _firebaseAuthService!.loginWithMail(email, password);
    return result;
  }

  Future addData({String? motto, String? name}) async {
    await _firestoreService!.addDataToFirestore(motto: motto, name: name);
  }

  Future<QuerySnapshot> readData() async {
    var data = await _firestoreService!.readDataFromFirestore();
    return data;
  }

  String getUserUid() {
    return _firebaseAuthService!.firebaseAuthService.currentUser!.uid;
  }

  Future removeData(String mottoId) async {
    await _firestoreService!.removeData(mottoId);
  }

  Future updateData(String mottoId, String name, String motto) async {
    await _firestoreService!.updateData(mottoId, name, motto);
  }
}
