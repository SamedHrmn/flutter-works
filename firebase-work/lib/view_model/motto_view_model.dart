import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_work/model/motto_model.dart';
import 'package:firebase_work/repository/my_repository.dart';
import 'package:firebase_work/utils/locator.dart';
import 'package:flutter/material.dart';

enum AppState { LOADING, LOADED, ERROR }

class MottoViewModel extends ChangeNotifier {
  AppState? _state;
  final Repository? _repository = getIt<Repository>();

  AppState? get state => _state;
  List<Motto> mottos = [];
  List<String> currentUserMottosID = [];

  late String? _userUid;

  set userUid(String? uid) {
    this._userUid = uid;
  }

  String? get userUid => _userUid;

  set state(AppState? state) {
    this._state = state;
    notifyListeners();
  }

  Future<bool> registerWithEmail(String email, String password) async {
    state = AppState.LOADING;

    var result = await _repository!.registerWithMail(email, password);
    if (result is! User) {
      state = AppState.ERROR;
      return false;
    }

    state = AppState.LOADED;
    return true;
  }

  Future loginWithMail(String email, String password) async {
    state = AppState.LOADING;
    bool result = await (_repository!.loginWithMail(email, password));
    if (!result) {
      state = AppState.ERROR;
      throw Exception("Login exception");
    }
    state = AppState.LOADED;
    return true;
  }

  Future addMotto({String? motto, String? name}) async {
    state = AppState.LOADING;
    await _repository!.addData(motto: motto, name: name);
    state = AppState.LOADED;
  }

  Future readMotto() async {
    state = AppState.LOADING;
    var querySnapshot = await _repository!.readData();

    mottos.clear();
    for (DocumentSnapshot d in querySnapshot.docs) {
      print(d.data()!["name"]);
      Motto motto = Motto.fromMap(d.data()!);
      mottos.add(motto);
    }

    state = AppState.LOADED;
  }

  String? getUserUid() {
    state = AppState.LOADING;
    userUid = _repository!.getUserUid();
    state = AppState.LOADED;
  }

  Future removeMotto(String mottoId) async {
    state = AppState.LOADING;
    await _repository!.removeData(mottoId);
    mottos.removeWhere((element) => element.mottoID == mottoId);
    state = AppState.LOADED;
  }

  Future updateMotto(String mottoId, String name, String motto) async {
    state = AppState.LOADING;
    await _repository!.updateData(mottoId, name, motto);
    mottos.forEach((element) {
      if (element.mottoID == mottoId) {
        element.name = name;
        element.motto = motto;
      }
    });

    state = AppState.LOADED;
  }
}
