import 'package:firebase_auth/firebase_auth.dart'
    as firebase;

import '../../../models/user.dart';

import '../auth/auth_service.dart';

class FirebaseAuthService
    implements AuthService {

  final firebase.FirebaseAuth
      _auth =
          firebase.FirebaseAuth.instance;

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {

    final credential =
        await _auth
            .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser =
        credential.user!;

    return User((b) => b

      ..uid = firebaseUser.uid

      ..name = name

      ..email = email

      ..createdAt =
          DateTime.now()
              .millisecondsSinceEpoch,
    );
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {

    final credential =
        await _auth
            .signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser =
        credential.user!;

    return User((b) => b

      ..uid = firebaseUser.uid

      ..name =
          firebaseUser.displayName ?? ''

      ..email =
          firebaseUser.email ?? ''

      ..createdAt =
          DateTime.now()
              .millisecondsSinceEpoch,
    );
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<User?> currentUser() async {

    final firebaseUser =
        _auth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return User((b) => b

      ..uid = firebaseUser.uid

      ..name =
          firebaseUser.displayName ?? ''

      ..email =
          firebaseUser.email ?? ''

      ..createdAt =
          DateTime.now()
              .millisecondsSinceEpoch,
    );
  }
}