import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/motto_model.dart';
import 'firebase_auth_service.dart';
import '../utils/locator.dart';

class FireStoreService {
  final _fireStoreService = FirebaseFirestore.instance;
  final FirebaseAuthService? _firebaseAuthService = getIt<FirebaseAuthService>();
  late Motto _mottoObj;

  Future addDataToFirestore({String? motto, String? name}) async {
    final DocumentReference _ref = _fireStoreService.collection("mottos").doc();
    _mottoObj = Motto.setMotto(userID: _firebaseAuthService!.firebaseAuthService.currentUser!.uid, mottoID: _ref.id, motto: motto, name: name);
    await _ref.set(_mottoObj.toMap());
  }

  Future<QuerySnapshot> readDataFromFirestore() async {
    final QuerySnapshot _ref = await _fireStoreService.collection("mottos").get();
    return _ref;
  }

  Future removeData(String mottoId) async {
    await _fireStoreService.collection("mottos").doc(mottoId).delete();
  }

  Future updateData(String mottoId, String name, String motto) async {
    await _fireStoreService.collection("mottos").doc(mottoId).update({'name': name, 'motto': motto});
  }
}
