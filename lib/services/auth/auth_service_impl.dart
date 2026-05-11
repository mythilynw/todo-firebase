import 'package:firebase_auth/firebase_auth.dart'
    as firebase;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';

import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final firebase.FirebaseAuth _auth =
      firebase.FirebaseAuth.instance;

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw 'User not created';
      }

      final user = User(
        (b) => b
          ..uid = firebaseUser.uid
          ..name = name
          ..email = email
          ..createdAt = DateTime.now()
              .millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());

      return user;
    } on firebase.FirebaseAuthException catch (e) {
      throw e.message ?? 'Registration failed';
    }
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw 'Login failed';
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      final data = doc.data();

      if (data == null) {
        throw 'User data not found';
      }

      return User.fromJson(data);
    } on firebase.FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}