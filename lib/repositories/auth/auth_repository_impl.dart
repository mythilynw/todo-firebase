import '../../models/user.dart';

import '../../services/auth/auth_service.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl
    implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({
    required this.authService,
  });

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authService.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return await authService.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await authService.logout();
  }
}