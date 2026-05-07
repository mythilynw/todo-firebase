import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Save user in Firestore
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'name': name,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(), 
        });
      }
    } on FirebaseAuthException catch (e) {
      
      throw e.message ?? 'Registration failed';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}