import '../../../models/user.dart';

abstract class AuthService {

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<User?> currentUser();
}