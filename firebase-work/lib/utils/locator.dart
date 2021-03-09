import 'package:get_it/get_it.dart';

import '../repository/my_repository.dart';
import '../service/firebase_auth_service.dart';
import '../service/firestore_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FireStoreService());
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => Repository());
}
