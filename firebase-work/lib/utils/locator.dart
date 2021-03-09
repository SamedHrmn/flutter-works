import 'package:firebase_work/repository/my_repository.dart';
import 'package:firebase_work/service/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_work/service/firestore_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FireStoreService());
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => Repository());
}
