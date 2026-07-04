import '../../data/datasources/remote/firebase/auth_datasource.dart';
import '../../data/datasources/remote/firebase/firestore_datasource.dart';
import '../../data/repositories/impl/auth_repository_impl.dart';
import '../../data/repositories/gym_repository.dart';
import '../../data/repositories/member_repository.dart';


class AppDependencies {
  AppDependencies._();

  static final AuthDataSource authDataSource = AuthDataSource();

  static final FirestoreDataSource firestoreDataSource =
  FirestoreDataSource();

  static final AuthRepositoryImpl authRepository =
  AuthRepositoryImpl(
    authDataSource: authDataSource,
    firestoreDataSource: firestoreDataSource,
  );
  static final GymRepositoryImpl gymRepository =
  GymRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
  static final MemberRepositoryImpl memberRepository =
  MemberRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
}
