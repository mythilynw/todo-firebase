import '../../../models/user.dart';

import '../auth/auth_service.dart';

class LocalAuthService
    implements AuthService {

  User? _user;

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {

    _user = User((b) => b

      ..uid =
          DateTime.now()
              .millisecondsSinceEpoch
              .toString()

      ..name = name

      ..email = email

      ..createdAt =
          DateTime.now()
              .millisecondsSinceEpoch,
    );

    return _user!;
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {

    if (_user == null) {
      throw Exception(
        'User not found',
      );
    }

    return _user!;
  }

  @override
  Future<void> logout() async {
    _user = null;
  }

  @override
  Future<User?> currentUser() async {
    return _user;
  }
}